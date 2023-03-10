class NotesController < ApplicationController
  def index
    @notes = Note.all.order(created_at: :desc)
  end

  def show
    @note = Note.find(params[:id])
  end

  def new
  end

  def create
    @note = Note.new
    @note.user = current_user
    tmpfile = Tempfile.new(['tmp', '.mp3'], binmode: true)
    content = params["files"].tempfile.read
    tmpfile.write(content)
    tmpfile.rewind
    @note.audio.attach(
      filename: "recording.mp3",
      io: File.open(tmpfile)
    )
    if @note.save
      puts "not pinging voice to text API"
      voice_to_text(@note, tmpfile)
    else
      flash[:alert] = "Note couldnt be saved, please try again"
      puts "couldnt save the note in create"
      redirect_to new_note_path
    end
  end

  def voice_to_text(note, tmpfile)
    client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_API_KEY'))
    puts 'transcribing using Whisper API..'
    response = client.translate(parameters: { model: "whisper-1", file: tmpfile })
    puts 'whisper api done'
    tmpfile.close
    tmpfile.unlink
    note.text = response["text"]
    puts "#{note.id} transcribed! #{note.text[0..100]}..."

    if @note.save
      puts "not pinging image generation API"
      generate_imgs(@note)
    else
      flash[:alert] = "Note couldnt be saved after voice generation, please try again"
      puts "couldnt save note in voice_to_text notes controller"
      # redirect_to new_note_path
    end

    # respond_to do |format|
    #   format.json { render json: note }
    # end
  end

  def generate_imgs(note)
    @note = note || Note.find(params[:id])
    payload = @note.text.split(/[,.]/)
    client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_API_KEY'))
    image_urls = []
    @note.ai_images.purge_later # Delete images from cloudinary and activerecord
    payload.each do |sentence|
      response = client.images.generate(parameters: { prompt: sentence, size: "256x256", n: 1 })
      remote_url = response["data"][0]["url"]
      @note.ai_images.attach(
        filename: "item.jpg",
        io: URI.parse(remote_url).open
      )
      image_urls.push(remote_url)
    end
    if @note.save
      puts "note was saved after image generation"
    else
      flash[:alert] = "Note couldnt be saved after image generation, please try again"
      # redirect_to new_note_path
    end

    respond_to do |format|
      format.json { render json: @note.ai_images.map(&:url) }
    end
  end

  def chatgpt
    client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_API_KEY'))
    @note ||= Note.new
    puts 'Expanding descriptions using ChatGPT API..'
    prefix = 'describe in a highly detailed way and in less than 15 words an image with the idea,'
    content = "Remember to call back Mum"
    payload = "#{prefix} '#{content}'"
    response = client.chat(parameters: { model: "gpt-3.5-turbo", messages: [{ role: "user", content: payload }], temperature: 0.7 })
    # response = client.chat( parameters: { model: "text-davinci-002", messages: [{ role: "user", content: "Hello!"}], temperature: 0.7 })
  end
end
