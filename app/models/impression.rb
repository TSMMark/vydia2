class Impression < ActiveRecord::Base
  attr_accessible :ip_address, :network_id, :referer, :request_url, :user_agent, :video_id

  belongs_to :video, inverse_of: :impressions
  belongs_to :network, inverse_of: :impressions

  validates_presence_of :video_id, :network_id

  has_one :play, inverse_of: :impression

  # only one of IP
  # validates_uniqueness_of :ip_address, :scope => [:network_id, :video_id]
  
end
