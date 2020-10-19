module MusclesHelper
  def render_with_hashtags(work_tag)
    work_tag.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/muscle/hashtag/#{word.delete('#')}" }.html_safe
  end
end
