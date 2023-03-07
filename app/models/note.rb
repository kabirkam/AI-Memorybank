class Note < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :reminders
  has_one_attached :audio
  has_many_attached :ai_images
end
