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
    i = super()
    i = i.where(video_id: video.id) if video
    i = i.select('DISTINCT video_id, ip_address') unless o[:all]
    i
  end
  
  def count_impressions video=nil, o={}
    i = self.impressions video, o
    i.all.count
  end

  def count_plays video=nil, o={}
    i = self.impressions video, o
    i.joins(:play).all.count
  end

end
