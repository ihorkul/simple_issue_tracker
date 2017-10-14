module IssuesHelper
  def issues_with(status)
    @issues.select { |issue| issue.status_id == status.id }
  end

  def ticket_class(issue)
    if issue.user_id.nil?
      'panel-default'
    else
      'panel-primary'
    end
  end
end
