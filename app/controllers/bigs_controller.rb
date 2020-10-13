class BigsController < ApplicationController
 def show
     @big = Big.find(params[:id])
     @part = @big.parts
  end

  def destroy
    @part = Part.find(params[:id])
    @part.destroy
    redirect_to big_path(@part.big_id)
  end

end
