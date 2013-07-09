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
    if id.numeric?
      return super id
    else
      return find_by_token id
    end
  end

end
