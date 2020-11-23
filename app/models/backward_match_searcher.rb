class BackwardMatchSearcher
  def initialize(model, content)
    @model = model
    @content = content
  end
  def execute
    return [] unless user? || muscle? # user でも muscleでもない model名だった場合のことを考える
    if user?
      User.backward_name_match(@content) # user.rbに定義したscopeを使う
    elsif muscle?
      Muscle.backward_work_tag_match(@content) # muscle.rbに定義したscopeを使う
    end
  end
  private
  def user?
    @model == 'user'
  end
  def muscle?
    @model == 'muscle'
  end
end