class Network < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name

  uniquify :token do
    SecureRandom.uuid.split('-').first
  end

  has_many :impressions, inverse_of: :network
  has_many :videos, through: :impressions


  # find by internal id or youtube video_id
  def self.find(id)
    if !id || id.numeric?
      return super id
    else
      return find_by_token id
    end
  end


  def videos
    super.group('videos.id').all
  end

  def impressions video=nil
    impressions = super
    impressions.where video_id: video.id if video
  end

  def count_impressions video=nil
    self.impressions(video).count
  end

end
