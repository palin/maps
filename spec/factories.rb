FactoryGirl.define do

  factory :user do
    sequence(:login) { |n| "user#{n}"}
    password "password"
    password_confirmation "password"
    sequence(:email) { |n| "#{login}-#{n}@example.com"}
  end
end