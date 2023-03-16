class RemindersController < ApplicationController
  def create
    @note = Note.find(params[:note_id])
    if @note.reminder.nil?
      puts "creating new reminder"
      @reminder = Reminder.new(date_time: reminder_params['date_time'].to_datetime)
      @note.reminder = @reminder
      @note.save
      flash[:notice] = "reminder saved!"
      # flash[:message] = "reminder saved!"
    else
      flash[:notice] = "reminder already exists!"
    end
    redirect_to request.referrer
  end

  def update
    @note = Note.find(params[:note_id])
    @reminder = Reminder.new(date_time: reminder_params['date_time'].to_datetime)
    @note.reminder = @reminder
    @note.save
    flash[:notice] = "reminder saved!"
    redirect_to request.referrer
  end

  private

  def reminder_params
    params.require(:reminder).permit(:note_id, :date_time)
  end
end
