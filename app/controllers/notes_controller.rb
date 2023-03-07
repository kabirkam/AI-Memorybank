class NotesController < ApplicationController
  def index
    @notes = Note.all
  end

  def show
    @notes = Note.find(params[:id])
  end

  # def destroy
  #   #check this with Aamir
  # end

  # def voice_to_text(note)
  #   puts 'building tmp file and getting mp3 data from file'
  #   tmpfile = Tempfile.new(['tmp', '.mp3'], binmode: true)
  #   content = URI.parse(note.audio.url.sub('http:', 'https:')).read
  #   tmpfile.write(content)
  #   tmpfile.rewind
  #   puts 'transcribing using Whisper API..'
  #   response = client.translate(
  #     parameters: {
  #       model: "whisper-1",
  #       file: tmpfile
  #     }
  #   )
  #   tmpfile.close
  #   tmpfile.unlink
  #   puts 'api done'
  #   note.text = response["text"]
  #   note.save
  #   puts "#{note.id} transcribed! #{note.text[0..10]}..."
  # end
end
