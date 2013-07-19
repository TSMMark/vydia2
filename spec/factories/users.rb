# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :user do
    email
    password  "foobar123"
    password_confirmation { "#{password}" }
  end
  factory :user_default, parent: :user do
  end
  factory :user_non_trendsetter, parent: :user do
    email { FactoryGirl.generate :bad_email }
  end

end
