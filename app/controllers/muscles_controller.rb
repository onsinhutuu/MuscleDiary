class MusclesController < ApplicationController
  def show
    @muscle = Muscle.find(params[:id])
    @user = @muscle.user
  end

  def index
    @user = current_user
    @muscles = Muscle.all
  end

  def following
  end

  def edit
  end

  def new
    @muscle = Muscle.new
  end

  def create
    @muscle = Muscle.new(muscle_params)
    @muscle.user_id = current_user.id
    @muscle.save
    redirect_to muscle_path(@muscle)
  end

  def destroy
    @muscle = Muscle.find(params[:id])
    @muscle.destroy
    redirect_to muscle_path
  end

  private
    def muscle_params
        params.require(:muscle).permit(:memo, :genre, :set_count, :weight, :rep)
    end
end
