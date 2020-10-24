module MusclesHelper
  def render_with_hashtags(work_tag)
    sanitize work_tag.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/muscle/hashtag/#{word.delete('#')}" }
    # gsubでハッシュタグ(/[#＃])と＃についてる文字(\w\p{Han}ぁ-ヶｦ-ﾟー]+/)をlink_to wordでリンクにして、sanitizeでhtml化している。
    # sanitizeを使う理由はXSS対策である。.html_safeだとrubocopにも怒られる
  end
end
