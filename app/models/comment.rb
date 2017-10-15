class Comment < ApplicationRecord
  validates_presence_of :text

  belongs_to :user, optional: true
  belongs_to :issue

  after_commit :send_email

  private

  def send_email
    IssueMailer.inform_user(issue_id).deliver_later if user_id
  end
end
