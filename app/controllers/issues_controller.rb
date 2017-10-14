class IssuesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)
    if @issue.save
      flash[:success] = 'Ticket was successfuly created'
      redirect_to new_issue_path
    else
      render 'new'
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:user_name, :email, :department_id, :subject, :content)
  end
end
