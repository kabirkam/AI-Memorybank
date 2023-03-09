class NotesController < ApplicationController
  def index
    @notes = Note.all.order(created_at: :desc)
  end

  def show
    @note = Note.find(params[:id])
  end

  # def destroy
  #   #check this with Aamir
  # end
end
