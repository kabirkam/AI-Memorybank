class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def test
  end

  def voice_to_text
    # debugger
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
    note = Note.new
    puts 'building tmp file and getting mp3 data from file'
    tmpfile = Tempfile.new(['tmp', '.mp3'], binmode: true)
    content = params["files"].tempfile.read
    tmpfile.write(content)
    tmpfile.rewind
    puts 'transcribing using Whisper API..'
    response = client.translate(
      parameters: {
        model: "whisper-1",
        file: tmpfile
      }
    )
    tmpfile.close
    tmpfile.unlink
    puts 'api done'
    note.text = response["text"]
    note.user = current_user
    note.save
    puts "#{note.id} transcribed! #{note.text[0..100]}..."
    # return note.text
    # add logic to show the transcribed message
    respond_to do |format|
      format.json { render json: note }
    end
  end

  def generate_imgs
    note = Note.find(params[:id])
    payload = note.text.split('.')
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
    image_urls = []
    payload.each do |sentence|
      image_urls.push(client.images.generate(parameters: { prompt: sentence, size: "256x256", n: 1 }))
    end
    # img_urls = []
    # payload.each do |sentence|
    #   response = client.images.generate(parameters: { prompt: sentence, size: "256x256", n: 2 })
    #   response["data"].each do |data|
    #     img_urls.push(data["url"])
    #   end
    # end

    # debugger

    respond_to do |format|
      format.json { render json: image_urls }
    end
  end



  def chatgpt
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
    @note = @note || Note.new
    puts 'Expanding descriptions using ChatGPT API..'
    prefix = 'describe in a highly detailed way and in less than 15 words an image with the idea,'
    content = "Remember to call back Mum"
    payload = "#{prefix} '#{content}'"
    response = client.chat( parameters: { model: "gpt-3.5-turbo", messages: [{ role: "user", content: payload}], temperature: 0.7 })
    # response = client.chat( parameters: { model: "text-davinci-002", messages: [{ role: "user", content: "Hello!"}], temperature: 0.7 })
  end
end
