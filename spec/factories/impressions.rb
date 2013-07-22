# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :impression do
    ip_address
    referer
    request_url
    user_agent

    ignore do
      play_state nil
    end

    after :create do |i, e|
      unless e.play_state.nil?
        p = Play.generate(i)
        p.state = e.play_state
        p.save!

        # puts p.to_yaml
      end
    end

  end
  factory :impression_default, parent: :impression_with_possible_play do
  end

  factory :impression_with_play, parent: :impression do
    play_state { (0..4).sample }
  end

  # factory :impression_with_possible_play, parent: :impression do
  #   after :create do |i|
  #     Play.generate(i) if (0,1).sample == 1
  #   end
  # end

end
