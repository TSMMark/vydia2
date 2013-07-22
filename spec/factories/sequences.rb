# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:name)       { |n| "Example User Name #{n}" }
  sequence(:email)      { |n| "foo#{n}@trendsettermarketing.net" }
  sequence(:bad_email)  { |n| "foo#{n}@example.com" }
end
