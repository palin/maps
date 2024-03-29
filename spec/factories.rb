FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "User Userovsky#{n}"}
    sequence(:login) { |n| "user#{n}"}
    password "password"
    password_confirmation "password"
    sequence(:email) { |n| "login-#{n}@example.com"}
  end

  factory :report do
    sequence(:title) { |n| "Tytul zgloszenia nr#{n}"}
    sequence(:description ) { |n| "To jest opis zgloszenia nr#{n}"}
    photo File.open("#{Rails.root}/spec/rails.png", "r")
    association(:category)
    latitude 52.123456
    longitude 16.123456
  end

  factory :category do
    unique_id { "#{SecureRandom.hex[1]}#{SecureRandom.hex[3]}#{SecureRandom.hex[9]}" }
  end

  factory :opinion do
    sequence(:title) { |n| "Tytul nr#{n}"}
    sequence(:description) { |n| "Opis opinii nr#{n} opis opinii"}
    association(:report)
  end

  factory :abuse do
    name "spam"
    association(:report)
  end
end
