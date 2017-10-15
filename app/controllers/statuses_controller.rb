class StatusesController < ApplicationController
  
  def index
    @statuses = Status.all
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    flash[:success] = 'Status was successfuly created' if @status.save
  end

  private

  def status_params
    params.require(:status).permit(:name)
  end
end
