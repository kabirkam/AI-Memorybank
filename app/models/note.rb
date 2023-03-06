class Note < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :ai_image
end
