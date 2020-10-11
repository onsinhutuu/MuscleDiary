class BigsController < ApplicationController
 def show
     @big = Big.find(params[:id])
     @part = @big.parts
  end
end
