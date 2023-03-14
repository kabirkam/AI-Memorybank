class SentencesController < ApplicationController
  def like_sentence
    puts "hello"
    json = JSON.parse(request.body.read)
    @sentence = Sentence.find(json["sentence_id"])
    @sentence.toggle


    # redirect_to note_path(@sentance.note)
  end
end
