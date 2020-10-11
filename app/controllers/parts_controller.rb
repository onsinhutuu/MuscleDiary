class PartsController < ApplicationController
  before_action :authenticate_user!
  def new
  	@part = Part.new
    @parts = current_user.parts
    @bigs = Big.all
  end

  def create
  	@part = Part.new(part_params)
    @part.user_id = current_user.id
    if @part.save
        redirect_to big_path(@part.big_id)
    elsif params[:part][:big_id] ==  "" && params[:part][:name] ==  ""
      redirect_to request.referer
      flash[:notice] = "部位と種目が入力されていません"
    elsif params[:part][:big_id] ==  ""
      redirect_to request.referer
      flash[:notice] = "部位が入力されていません"
    else
      @bigs = Big.all
      redirect_to request.referer
      flash[:notice] = "種目が入力されていません"
    end
  end


  private
	   def part_params
	        params.require(:part).permit(:name, :big_id)
	   end
end
