FactoryGirl.define do
  factory :issue do
    subject "MyString"
    content "MyText"
    department_id 1
    user nil
    status nil
    name "MyString"
    email "MyString"
  end
end
