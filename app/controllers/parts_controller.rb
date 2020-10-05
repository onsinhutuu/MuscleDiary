class PartsController < ApplicationController
  def new
  	@part = Part.new
  end

  def create
  	@part = Part.new(part_params)
    @part.user_id = current_user.id
    @part.save
    redirect_to user_path(@part)
  end

  private
	   def part_params
	        params.require(:part).permit(:name)
	   end
end
