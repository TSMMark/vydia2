# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :youtube do
    skip_create

    initialize_with { new(FactoryGirl.generate :video_token) }
  end
end
