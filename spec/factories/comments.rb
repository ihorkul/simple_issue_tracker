FactoryGirl.define do
  factory :comment do
    text "MyText"
    issue_id nil
    user_id nil
  end
end
