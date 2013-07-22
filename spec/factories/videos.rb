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
          i=FactoryGirl.build :impression_default do |i|
            i.video_id    = video.id
            i.network_id  = n.id
          end
          i.save
        end
      end
    end


  end

end
