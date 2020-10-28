class BigsController < ApplicationController
  def show
    @big = Big.find(params[:id])
    @part = Part.where(big_id: @big, user_id: current_user.id)
  end

  def destroy
    @part = Part.find(params[:id])
    @part.destroy
    redirect_to big_path(@part.big_id)
  end

end
