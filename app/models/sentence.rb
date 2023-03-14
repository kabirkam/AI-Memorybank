class Sentence < ApplicationRecord
  belongs_to :note
  has_one_attached :ai_image

  validates :text, presence: true

  def toggle
    if self.like == false
      self.like = true
    else
      self.like = false
    end
    self.save
  end
end
