class UserComment < ApplicationRecord
  belongs_to :user
  belongs_to :intro_video
  has_many :reactions, dependent: :destroy#, foreign_key: "Reacted_id"

  validates :content, presence: true # Ensure the comment content is present
  
  # has_many :reacts, as: :imageable
end
