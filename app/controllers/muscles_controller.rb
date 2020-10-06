class MusclesController < ApplicationController
  def show
    @muscle = Muscle.find(params[:id])
    @user = @muscle.user
    @muscle_comment = MuscleComment.new
  end

  def index
    @user = current_user
    @muscles = Muscle.all.page(params[:page]).per(10)
  end

  def following
    user = User.find(current_user.id)
    @users = user.followings
    @muscles = Muscle.where(user_id: @users).order("created_at DESC").page(params[:page]).per(10)
  end

  def edit
     @muscle = Muscle.find(params[:id])
     @user = current_user
     if @muscle.user == current_user
     else
      redirect_to muscles_path
     end
  end

  def update
    @muscle = Muscle.find(params[:id])
    if @muscle.update(muscle_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to muscle_path(@muscle)
    else
      render :edit
    end
  end

  def new
    @muscle = Muscle.new
    @user = current_user
  end

  def create
    @muscle = Muscle.new(muscle_params)
    @muscle.user_id = current_user.id
    @muscle.save
    redirect_to muscle_path(@muscle.id)
  end

  def destroy
    @muscle = Muscle.find(params[:id])
    @muscle.destroy
    redirect_to muscles_path
  end

  private
    def muscle_params
        params.require(:muscle).permit(:memo, :genre, :set_count, :weight, :rep, :part_id)
    end
end
