class Reaction < ApplicationRecord
  belongs_to :user_comment
  belongs_to :user#:reactor, class_name: 'User'

  validates :user_id, presence: true
  validates :user_comment_id, presence: true
end
