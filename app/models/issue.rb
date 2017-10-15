class Issue < ApplicationRecord
  validates_presence_of :user_name, :email, :subject, :content, :key
  validates_uniqueness_of :key
  belongs_to :user, optional: true
  belongs_to :status
  belongs_to :department
  has_many :comments

  before_validation :set_validatable_fields, if: ->(issue) { issue.new_record? }

  private

  def set_validatable_fields
    set_status unless status_id
    generate_key unless key
  end

  def set_status
    self.status_id = 1
  end

  def generate_key
    while true do
      new_key = "#{generate_char_string(2)}-#{generate_hex_num(1)}-#{generate_char_string(2)}-#{generate_hex_num(1)}-#{generate_char_string(2)}"
      break unless Issue.exists?(key: new_key)
    end
    self.key = new_key
  end

  def generate_char_string(lenght)
    SecureRandom.urlsafe_base64(lenght).upcase
  end

  def generate_hex_num(lenght)
    SecureRandom.hex(lenght).upcase
  end
end
