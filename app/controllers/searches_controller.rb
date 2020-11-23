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
    PerfectMatchSearcher.new(model, content).execute
  end

  def forward(model, content)
    ForwardMatchSearcher.new(model, content).execute
  end

  def backward(model, content)
    BackwardMatchSearcher.new(model, content).execute
  end

  def partical(model, content)
    ParticalMatchSearcher.new(model, content).execute
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
