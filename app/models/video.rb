class Video < ActiveRecord::Base
  include VideosHelper

  attr_accessible :token, :name, :cpm

  belongs_to :user, inverse_of: :videos

  validates_presence_of :name, :token
  validates_uniqueness_of :token

  has_many :impressions, inverse_of: :video
  has_many :networks, through: :impressions

  # find by internal id or youtube token
  def self.find(id)
    if !id || "#{id}".numeric?
      return super id
    else
      return find_by_token id
    end
  end

  def networks
    super.group('networks.id').all
  end

  def impressions network=nil, o={}
    o[:unique] = true if o[:unique].nil?
    i = super()
    i = i.where(network_id: network.id) if network
    i = i.select('DISTINCT network_id, ip_address') if o[:unique]
    i
  end
  
  def plays network=nil, o={}
    o[:min_state] = Play.default_min_state if o[:min_state].nil?
    o[:max_state] = Play.default_max_state if o[:max_state].nil?
    o[:min_state] = [o[:max_state], o[:min_state]].min
    i = self.impressions(network, o).joins(:play)
    i.where("state >= ? AND state <= ?", o[:min_state], o[:max_state])
  end

  def count_impressions network=nil, o={}
    i = self.impressions(network, o)
    i.all.count
  end

  def count_plays network=nil, o={}
    i = plays(network, o).all.count
  end

  def count_views network=nil
    count_plays network
  end


  def swf_link
    link_from_token self.token, :swf
  end
  def link
    link_from_token self.token
  end
end
