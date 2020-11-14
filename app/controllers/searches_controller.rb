class SearchesController < ApplicationController
  before_action :authenticate_user!
  def search
    @content = params['search']['content']
    @how = params['search']['how']
    @model = params['search']['model']
    @datas = search_for(@how, @model, @content).page(params[:page]).per(10)
  end

  private

  def match(model, content)
    if model == 'user'
      User.where(name: content)
    elsif model == 'muscle'
      Muscle.match_with_worktag(content)
    end
  end

  def forward(model, content)
    if model == 'user'
      User.where('name LIKE ?', "#{content}%")
    elsif model == 'muscle'
      Muscle.where('work_tag LIKE ?', "#{content}%")
    end
  end

  def backward(model, content)
    if model == 'user'
      User.where('name LIKE ?', "%#{content}")
    elsif model == 'muscle'
      Muscle.where('work_tag LIKE ?', "%#{content}")
    end
  end

  def partical(model, content)
    if model == 'user'
      User.where('name LIKE ?', "%#{content}%")
    elsif model == 'muscle'
      Muscle.where('work_tag LIKE ?', "%#{content}%")
    end
  end

  def search_for(how, model, content)
    case how
    when 'match'
      match(model, content)
    when 'forward'
      forward(model, content)
    when 'backward'
      backward(model, content)
    when 'partical'
      partical(model, content)
    end
  end
end
