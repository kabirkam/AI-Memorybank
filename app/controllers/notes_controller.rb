class NotesController < ApplicationController
  def index
    @notes = Note.all.order(created_at: :desc)
  end

  def show
    @notes = Note.find(params[:id])
  end

  # def destroy
  #   #check this with Aamir
  # end
end
