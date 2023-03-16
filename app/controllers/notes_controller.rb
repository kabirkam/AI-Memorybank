require 'open-uri'

class NotesController < ApplicationController
  def index
    @notes = Note.all.order(created_at: :desc)
    @loading_pic = "https://res.cloudinary.com/teepublic/image/private/s--c4AzvgDC--/t_Preview/t_watermark_lock/b_rgb:191919,c_lpad,f_jpg,h_630,q_90,w_1200/v1598801323/production/designs/13546919_0.jpg"
  end

  def show
    @note = Note.find(params[:id])
    @reminder = @note.reminder || Reminder.new
    @loading_pic = "https://res.cloudinary.com/teepublic/image/private/s--c4AzvgDC--/t_Preview/t_watermark_lock/b_rgb:191919,c_lpad,f_jpg,h_630,q_90,w_1200/v1598801323/production/designs/13546919_0.jpg"
  end

  def test
    @loading_pic = "https://res.cloudinary.com/teepublic/image/private/s--c4AzvgDC--/t_Preview/t_watermark_lock/b_rgb:191919,c_lpad,f_jpg,h_630,q_90,w_1200/v1598801323/production/designs/13546919_0.jpg"
  end

  def new
  end

  def create(mp3file, note_text)
    @note = Note.new
    @note.audio.attach(filename: "recording.mp3", io: File.open(mp3file))
    close_tmpfile_mp3(mp3file)

    # save note
    @note.user = current_user
    @note.text = note_text
    @note.save
    puts "#{@note.id} transcribed! #{@note.text[0..100]}..."

    respond_to do |format|
      format.json { render json: @note }
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy!
    redirect_to notes_path, status: :see_other
  end

  def open_tmpfile_mp3(tmpfile)
    mp3file = Tempfile.new(['tmp', '.mp3'], binmode: true)
    content = tmpfile.read
    mp3file.write(content)
    mp3file.rewind
    return mp3file
  end

  def close_tmpfile_mp3(mp3file)
    mp3file.close
    mp3file.unlink
  end

  def voice_to_text
    client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_API_KEY'))
    puts 'transcribing using Whisper API..'
    mp3file = open_tmpfile_mp3(params["files"].tempfile)
    response = client.translate(parameters: { model: "whisper-1", file: mp3file })
    puts 'api done'
    note_text = response["text"]
    create(mp3file, note_text)
  end

  def make_sentences(note)
    note.sentences.push(note.text.split(/[,.]/).map { |sent| Sentence.new(text: sent) }) if note.sentences.empty?
    return note
  end

  def generate_imgs
    @note = Note.find(params[:id])
    @note = make_sentences(@note)
    client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_API_KEY'))
    # @note.sentences.map { |sent| sent.ai_image.purge_later } # Delete images from cloudinary and activerecord
    @note.sentences.each do |sentence|
      next if sentence.like

      sentence.like = true
      sentence.ai_image.purge_later # Delete images from cloudinary and activerecord
      response = client.images.generate(parameters: { prompt: sentence.text, size: "256x256", n: 1 })
      sentence.ai_image.attach(filename: "item.jpg", io: URI.parse(response["data"][0]["url"]).open)
      sentence.save
    end
    @note.save

    respond_to do |format|
      format.json { render json: @note.sentences.map { |sent| sent.ai_image.url || @loading_pic } }
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
