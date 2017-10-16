FactoryGirl.define do
  factory :issue do
    subject "Test Issue"
    content "Test Content"
    department_id 1
    user_name "Username"
    email "client@mail.com"
  end

  factory :invalid_issue, class: 'Issue' do
    user_name nil
    email nil
    content nil
  end
end
