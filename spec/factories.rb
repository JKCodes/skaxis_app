FactoryGirl.define do
  factory :user do
    name "Test User"
    email "tester@example.com"
    status "test status"
    description "test description"
    password "secret"
    password_confirmation "secret"
  end
end
