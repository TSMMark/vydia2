# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :network do
    name
  end
  factory :network_default, parent: :network do
  end

end
