module MusclesHelper
  def render_with_hashtags(work_tag)
    work_tag.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/muscle/hashtag/#{word.delete('#')}" }.html_safe
    # work_tag.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/muscle/hashtag/word.delete('#')" }
    # gsubで/[#＃] = ハッシュタグと　＃についてる文字　＝　\w\p{Han}ぁ-ヶｦ-ﾟー]+/をlink_to wordでリンクにしている。
  end
end
