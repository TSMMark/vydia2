class Video < ActiveRecord::Base
  include VideosHelper

  attr_accessible :token, :name

  belongs_to :user, inverse_of: :videos

  validates_presence_of :name, :token
  validates_uniqueness_of :token

  has_many :impressions, inverse_of: :video
  has_many :networks, through: :impressions

  # find by internal id or youtube token
  def self.find(id)
    if id.numeric?
      return super id
    else
      return find_by_token id
    end
  end

  def networks
    super.group('networks.token').all
  end

  def swf_link
    link_from_token self.token, :swf
  end
  def link
    link_from_token self.token
  end
end
