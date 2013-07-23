# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    name
    token { FactoryGirl.generate :video_token }
    cpm
  end
  factory :video_default, parent: :video do
  end
  
  factory :video_with_impressions, parent: :video do
    ignore do
      network_count     Random.new.rand(1..4)
      impression_count  Random.new.rand(2..8)
    end

    after :create do |video, evaluator|
      evaluator.network_count.times do
        n = FactoryGirl.create :network_default
        evaluator.impression_count.times do
          FactoryGirl.create(:impression_with_play,
            video:    video,
            network:  n
          )
        end
      end
      # SpecHelper::PlayHelper.randomize_states
    end
  end



end
