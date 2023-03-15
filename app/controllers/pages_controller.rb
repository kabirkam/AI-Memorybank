require 'open-uri'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def profile
  end

  def test
    @note = Note.first
    @reminder = Reminder.new
  end
end
