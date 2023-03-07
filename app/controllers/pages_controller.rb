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
      format.json { render :json => note }  # note, no :location or :status options
    end
  end
end
