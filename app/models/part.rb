class Part < ApplicationRecord
  belongs_to :user
  belongs_to :big
  has_many :muscles, dependent: :destroy
  validates :name, presence: true
end
