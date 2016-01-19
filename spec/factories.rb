FactoryGirl.define do
  factory :user do
    sequence(:name)   { |n| "Person #{n}" }
    sequence(:email)  { |n| "person_#{n}@example.com" }
    status "test status"
    description "test description"
    password "secret"
    password_confirmation "secret"

    factory :admin do
      admin true
    end
  end
end
