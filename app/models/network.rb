class Network < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name

  uniquify :token do
    all_numbers = /^[0-9]+$/
    begin
      token = SecureRandom.uuid.split('-').first
    end while token =~ all_numbers
    token
  end

  has_many :impressions, inverse_of: :network
  has_many :videos, through: :impressions


  # find by internal id or youtube video_id
  def self.find(id)
    if !id || "#{id}".numeric?
      return super id
    else
      return find_by_token id
    end
  end


  def videos
    super.group('videos.id').all
  end

  def impressions video=nil, o={}
    o[:unique] = true if o[:unique].nil?
    i = super()
    i = i.where(video_id: video.id) if video
    i = i.select('DISTINCT video_id, ip_address') if o[:unique]
    i
  end
  
  def plays video=nil, o={}
    o[:min_state] = Play.default_min_state if o[:min_state].nil?
    o[:max_state] = Play.default_max_state if o[:max_state].nil?
    o[:min_state] = [o[:max_state], o[:min_state]].min
    i = self.impressions(video, o).joins(:play)
    i.where("state >= ? AND state <= ?", o[:min_state], o[:max_state])
  end

  def count_impressions video=nil, o={}
    i = self.impressions video, o
    i.all.count
  end

  def count_plays video=nil, o={}
    plays(video, o).all.count
  end

end
