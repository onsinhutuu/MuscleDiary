class MuscleCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @muscle = Muscle.find(params[:muscle_id])
    comment = current_user.muscle_comments.new(muscle_comment_params)
    comment.muscle_id = @muscle.id
    if comment.save

    else
      redirect_to request.referer
      flash[:notice] = 'コメントが入力されていません'
    end
  end

  def destroy
    @muscle = Muscle.find(params[:muscle_id])
    MuscleComment.find_by(id: params[:id], muscle_id: params[:muscle_id]).destroy
  end

  private

  def muscle_comment_params
    params.require(:muscle_comment).permit(:comment)
  end
end
