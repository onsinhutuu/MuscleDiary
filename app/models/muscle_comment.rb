class MuscleComment < ApplicationRecord
  belongs_to :user
  belongs_to :muscle
  validates :comment, presence: true

  def belongs_to_current_user?(current_user)
  	user == current_user
  end
end
