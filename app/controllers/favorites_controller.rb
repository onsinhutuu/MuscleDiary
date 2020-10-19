class FavoritesController < ApplicationController
  def create
    @muscle = Muscle.find(params[:muscle_id])
    favorite = current_user.favorites.new(muscle_id: @muscle.id)
    favorite.save
  end

  def destroy
    @muscle = Muscle.find(params[:muscle_id])
    favorite = current_user.favorites.find_by(muscle_id: @muscle.id)
    favorite.destroy
  end
end
