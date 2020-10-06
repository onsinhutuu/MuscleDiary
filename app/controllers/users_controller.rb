class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @muscle = Muscle.find(params[:id])
    @graph = Muscle.where(user_id: current_user.id)
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
       flash[:success] = "登録情報を更新しました"
       redirect_to user_path(@user)
    else
       render "edit"
    end
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, flash[:notice] = 'ありがとうございました'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted, :image)
  end

end
