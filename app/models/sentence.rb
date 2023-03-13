class Sentence < ApplicationRecord
  belongs_to :note
  has_one_attached :ai_image

  validates :text, presence: true
end
