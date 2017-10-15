class IssueMailer < ApplicationMailer
  def send_link(id)
    @issue = Issue.find_by_id(id)
    mail(to: @issue.email, subject: 'New ticket')
  end

  def inform_user(id)
    @issue = Issue.find_by_id(id)
    mail(to: @issue.email, subject: 'Ticket has changed')
  end
end
