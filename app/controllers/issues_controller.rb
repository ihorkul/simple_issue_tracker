class IssuesController < ApplicationController
  skip_before_action :authenticate_user!, except: [:index, :show]
  before_action :set_issue, only: [:update, :show]

  def index
    @statuses = Status.all.order(:id)
    @issues = Issue.search(current_user.id, params[:search]).includes(:department)
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

  def show
    @comment = Comment.new if @issue.user_id == current_user.id
  end

  def edit
    @issue = Issue.find_by(key: params[:key])
    @user_name = @issue.user_name
    @comment = Comment.new
  end

  def update
    @issue.assign_attributes(issue_params)
    @issue.user = current_user if @issue.user_id.nil?
    flash[:success] = 'Ticket was successfully updated.' if @issue.save
  end

  private

  def set_issue
    @issue = Issue.find params[:id]
  end

  def issue_params
    params.require(:issue).permit(:user_name, :email, :department_id, :subject, :content, :user_id, :status_id)
  end

  def search_params

  end
end
