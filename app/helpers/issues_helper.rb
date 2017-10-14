module IssuesHelper
  def issues_with(status)
    @issues.select { |issue| issue.status_id == status.id }
  end
end
