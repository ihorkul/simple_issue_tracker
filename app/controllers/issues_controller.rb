class IssuesController < ApplicationController
  skip_before_action :authenticate_user!, only: :new

  def index
    @statuses = Status.all.order(:id)
    @issues = Issue.all
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

  def update
    @issue.assign_attributes(issue_params)
    @issue.user_id = current_user.id if @issue.user_id.nil?
    respond_to do |format|
      if @issue.save
        format.html { render :new, success: 'Disease was successfully updated.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:user_name, :email, :department_id, :subject, :content, :user_id, :status_id)
  end
end
