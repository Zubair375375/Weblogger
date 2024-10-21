class Article < ApplicationRecord
  include Visible

  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy

  has_one_attached :image
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  before_destroy :purge_image


  def purge_image
    image.purge if image.attached?
  end
end
