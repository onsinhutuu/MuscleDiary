class Tag < ApplicationRecord
  has_many :muscle_tags, dependent: :destroy
  has_many :muscles, through: :muscle_tags
  validates :tag_name, presence: true
end
