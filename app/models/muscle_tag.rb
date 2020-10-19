class MuscleTag < ApplicationRecord
  belongs_to :muscle
  belongs_to :tag
  validates :muscle_id, presence: true
  validates :tag_id, presence: true
end
