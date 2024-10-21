class ProfileShare < ApplicationRecord
  belongs_to :user
  belongs_to :user, class_name: "User", foreign_key: "current_user_id"  # assuming `User` model represents users in your application

  validates :user_id, presence: true
  validates :current_user_id, presence: true
end
