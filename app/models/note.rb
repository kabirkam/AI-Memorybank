class Note < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :ai_images
  has_many :reminders
  has_one_attached :audio
end
