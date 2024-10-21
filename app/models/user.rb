class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_save { self.email = email.downcase }

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 10, 10 ]
  end

  has_one_attached :cover_image do |coverimg|
    coverimg.variant :thumb, resize_to_limit: [ 20, 20 ]
  end

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  # validates :login, presence: true, uniqueness: { case_sensitive: false }

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  # Relationships for following
  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_follows, source: :followed

  # Relationships for followers
  has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

  has_many :reverse_follows, class_name: "Follow", foreign_key: :followed_id
  has_many :followers, through: :reverse_follows, source: :follower

  # has_one_attached :video
  has_one :intro_video, dependent: :destroy
  has_many :user_comments, dependent: :destroy # A user can have many comments
  has_many :reactions, dependent: :destroy# , foreign_key: "Reactor_id"
  has_many :profile_shares, dependent: :destroy
end
