class ApplicationMailer < ActionMailer::Base
  default from: 'admin@issue_tracker.com'
  layout 'mailer'
end
