# Read about factories at https://github.com/thoughtbot/factory_girl


def random_youtube_token
  ['r_Jwx3XKcXU','JjDre7EaHFQ'].sample
end

FactoryGirl.define do
  factory :video do
    name
    token { random_youtube_token }
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
