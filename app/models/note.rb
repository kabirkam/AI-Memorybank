class Note < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :reminders
  has_many :sentences
  has_one_attached :audio

  validates :text, :audio, presence: true
end
