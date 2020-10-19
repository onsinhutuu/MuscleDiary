class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :image
  has_many :muscles, dependent: :destroy
  has_many :parts, dependent: :destroy
  has_many :bigs, through: :parts
  has_many :favorites, dependent: :destroy
  has_many :muscle_comments, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship', foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  has_many :contacts, dependent: :destroy
  validates :name, presence: true
  def active_for_authentication?
    super && (is_deleted == false)
  end

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
end
