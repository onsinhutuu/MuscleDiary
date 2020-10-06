class Muscle < ApplicationRecord
	belongs_to :user
	belongs_to :part
	has_many :favorites, dependent: :destroy
	has_many :muscle_comments, dependent: :destroy
	def favorited_by?(user)
    	favorites.where(user_id: user.id).exists?
  	end
end
