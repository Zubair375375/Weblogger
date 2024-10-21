class IntroVideo < ApplicationRecord
  belongs_to :user

  # validates :video, presence: true

  has_one_attached :video
  # has_many :reacts, as: :imageable
  # has_many :reacts, dependent: :destroy, foreign_key: "Reacted_id"
  
  has_many :user_comments, dependent: :destroy
end