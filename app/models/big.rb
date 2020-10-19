class Big < ApplicationRecord
  has_many :parts, dependent: :destroy
  has_many :users, through: :parts
  validates :name, presence: true
end
