# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:name) { |n| "Example Name #{n}" }
  sequence(:email) { |n| "foo#{n}@trendsettermarketing.net" }
  sequence(:bad_email) { |n| "foo#{n}@example.com" }

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
