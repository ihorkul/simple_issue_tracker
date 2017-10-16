FactoryGirl.define do
  factory :user do
    email 'user1@mail.com'
    password '111111'
  end

  factory :admin, class: 'user' do
    email 'admin1@mail.com'
    password '111111'
    is_admin true
  end
end
