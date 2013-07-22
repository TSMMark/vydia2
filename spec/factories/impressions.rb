# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :impression do
    ip_address
    referer
    request_url
    user_agent
  end
  factory :impression_default, parent: :impression_with_possible_play do
  end

  factory :impression_with_play, parent: :impression do
    after :create do |i|
      Play.generate(i)
    end
  end

  factory :impression_with_possible_play, parent: :impression do
    after :create do |i|
      Play.generate(i) if [0,1].sample == 1
    end
  end
  
end
