class CommentsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    flash[:success] = 'Comment was successfuly created' if @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:issue_id, :user_id, :text)
  end
end
