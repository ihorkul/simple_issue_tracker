module IssuesHelper
  def issues_with(status)
    @issues.select { |issue| issue.status_id == status.id }
  end

  def ticket_class(issue)
    return 'panel-default' if issue.user_id.nil?

    'panel-primary'
  end
end
