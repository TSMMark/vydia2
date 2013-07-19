class Video < BaseModel
  include VideosHelper

  include_helpers

  attr_accessible :token, :name, :cpm,
                  :ad_after, :ad_bottom,
                  :yt_title,
                  :yt_thumb, :yt_rating,
                  :yt_view_count, :yt_favorite_count

  belongs_to :user, inverse_of: :videos

  validates_presence_of :name, :token, :cpm
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

  # youtube stats
  def score
    yt_rating.round
  end

  def thumb_element_hover options={thumb:{}}
    options[:class] = "#{options[:class]} thumb-container"
    el = thumb_element(options[:thumb])
    options[:thumb] = nil
    content_tag(:div,
      el,
      options
    ).html_safe
    
  end

  def thumb_element options={}
    options         ||= {}
    options[:alt]   = yt_title if options[:alt]   == nil
    options[:title] = yt_title if options[:title] == nil
    options[:style] = "#{options[:style]} background-image:url(#{thumb "hqdefault"});"
    options[:class] = "#{options[:class]} video-thumb"
    href    = (options[:link_to] == :player) ? self.link : video_path(self)
    target  = (options[:link_to] == :player) ? '_blank' : '_self'

    content_tag(:a,
      content_tag(:div, nbsp, options).html_safe,
      href: href, target: target
    ).html_safe
  end
  def thumb size='default'
    Youtube.thumb yt_thumb, size
  end
  # internal counts
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
    count_plays network, unique: false
  end


  def network_spending network, views = nil
    views ||= count_views(network)
    calculate_spending views, self.cpm
  end

  def calculate_spending views, bid_cpm
    r = cpm * views.to_f / Money.one_thousand
  end

  # prepare bid_cpm to be multiplied a view count
  def cpm
    super
  end


  def swf_link
    link_from_token self.token, :swf
  end
  def link
    link_from_token self.token
  end
end
