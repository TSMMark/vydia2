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

end