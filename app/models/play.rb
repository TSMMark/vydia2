class Play < ActiveRecord::Base

  attr_accessible :impression_id, :seconds_passed, :state

  belongs_to :impression, inverse_of: :play
  
  def self.generate impression
    p = impression.play
    if !p
      p   = Play.new
      p.impression_id   = impression.id
      p.seconds_passed  = (Time.now - impression.created_at).to_i
      p.save!
    end
    p
  end

  def state
    super
  end

  # play 100%
  def self.full_plays
    where("state >= ?", 4)
  end

  # play >= 25%
  def self.views
    where("state >= ? AND state <= ?", default_min_state, default_max_state)
  end

  # 0-5 : 0%-100%
  def self.default_min_state
    # a video needs to be played 25% to count as a play
    1
  end

  def self.default_max_state
    4
  end

end