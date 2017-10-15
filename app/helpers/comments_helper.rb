module CommentsHelper
  def comment_user_name(comment)
    if comment.user_id.nil?
      issue = @issue || comment.issue
      issue.email
    else
      comment.user.email
    end
  end

  def comment_user_id
    @issue.user_id if @user_name.nil?
  end
end
