class Video < ActiveRecord::Base
  include VideosHelper

  attr_accessible :video_id, :name

  belongs_to :user, inverse_of: :videos

  validates_presence_of :name, :video_id

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
