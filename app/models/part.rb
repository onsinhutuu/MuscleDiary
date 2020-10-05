class Part < ApplicationRecord
	belongs_to :user
	has_many :muscles
end
