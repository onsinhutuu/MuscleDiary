class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def follows
  end

  def follower
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
    redirect_to root_path, info: 'ありがとうございました'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end

end
