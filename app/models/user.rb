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
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: :following_id,
                                  dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: :follower_id,
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following
  has_many :contacts, dependent: :destroy
  validates :name, presence: true, length: { in: 2..20 }
  def active_for_authentication?
    super && (is_deleted == false)
  end

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: 'ゲスト') do |user|
    user.password = SecureRandom.urlsafe_base64
    end
  end
end
