class Note < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :ai-image

  
end
