class Muscle < ApplicationRecord
  belongs_to :user
  belongs_to :part
  has_many :favorites, dependent: :destroy
  has_many :muscle_comments, dependent: :destroy
  has_many :muscle_tags, dependent: :destroy
  has_many :tags, through: :muscle_tags
  validates :weight, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :set_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :memo, presence: true
  validates :rep, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def belongs_to_current_user?(current_user)
    user == current_user
  end

  def self.match_with_worktag(content)
    where(work_tag:content)
  end

  after_create do
    # 1.controller側でcreateしたmuscleを取得
    muscle = Muscle.find_by(id: id)
    # 2.正規表現を用いて、muscleのwork_tag内から『#○○○』の文字列を検出
    tags = work_tag.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    # 3.mapメソッドでtags配列の要素一つ一つを取り出して、先頭の#を取り除いてDBへ保存する
    tags.uniq.map do |t|
      tag = Tag.find_or_create_by(tag_name: t.downcase.delete('#'))
      muscle.tags << tag
    end
  end
end
