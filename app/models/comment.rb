class Comment < ApplicationRecord
  validates_presence_of :text

  belongs_to :user, optional: true
  belongs_to :issue
end
