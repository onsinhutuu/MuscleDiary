class Muscle < ApplicationRecord
	belongs_to :user
	belongs_to :part
	has_many :favorites, dependent: :destroy
	has_many :muscle_comments, dependent: :destroy
	has_many :muscle_tags, dependent: :destroy
    has_many :tags, through: :muscle_tags
    validates :weight, presence: true
    validates :set_count, presence: true
    validates :memo, presence: true
    validates :rep, presence: true
	def favorited_by?(user)
    	favorites.where(user_id: user.id).exists?
  	end

  	after_create do
    #1.controller側でcreateしたmuscleを取得
    muscle = Muscle.find_by(id: self.id)
    #2.正規表現を用いて、muscleのmemo内から『#○○○』の文字列を検出
    tags  = self.work_tag.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    #3.mapメソッドでtags配列の要素一つ一つを取り出して、先頭の#を取り除いてDBへ保存する
	    tags.uniq.map do |t|
	      tag = Tag.find_or_create_by(tag_name: t.downcase.delete('#'))
	      muscle.tags << tag
	    end
	end
end
