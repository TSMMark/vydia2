class Video < ActiveRecord::Base
  include VideosHelper

  attr_accessible :video_id, :name

  belongs_to :user, inverse_of: :videos

  validates_presence_of :name, :video_id
  validates_uniqueness_of :video_id

  has_many :impressions, inverse_of: :video
  has_many :networks, through: :impressions

  # find by internal id or youtube video_id
  def self.find(id)
    if id.numeric?
      return super id
    else
      return find_by_video_id id
    end
  end

  # def video_id
  #   video_id_of_url self.link
  # end
  def swf_link
    swf_link_of_id self.video_id
  end
  def link
    link_from_id self.video_id
  end
end
