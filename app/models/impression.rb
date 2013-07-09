class Impression < ActiveRecord::Base
  attr_accessible :ip_address, :network_id, :referer, :request_url, :user_agent, :video_id

  belongs_to :video, inverse_of: :impressions
  belongs_to :network, inverse_of: :impressions

end
