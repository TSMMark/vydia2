class Youtube

  # include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  require "net/http"
  require "uri"

  attr_accessor :token, :gdata,
                :title, :base_thumb_url,
                :yt_rating, :max_rating, :min_rating,
                :rating_100,
                :view_count, :favorite_count,
                :yt_published

  def initialize(token)
    self.token = token
    self.gdata = Youtube.get_gdata token
    collect_important_attrs
  end

  def thumb size="default"
    Youtube.thumb(self.base_thumb_url, size)
  end

  def _thumb_url
    self.base_thumb_url = self.gdata["media$group"]["media$thumbnail"][0]["url"].gsub("default","%size")
  end

  def _thumbs
    thumbs   = {}
    self.gdata["media$group"]["media$thumbnail"].each do |t|
      thumbs[t["yt$name"]] = {
        "url"     => t["url"],
        "height"  => t["height"],
        "width"   => t["width"]
      }
    end
    self.thumbs = thumbs
  end

  def _rating_100
    max = self.max_rating
    min = self.min_rating
    self.rating_100 = (self.yt_rating - min) * (100 / (max - min))
  end

  def persisted?
    false
  end




  # Class Methods
  def self.thumb url, size="default"
    # sizes = default, mqdefault, hqdefault, sddefault, start, middle, end
    url.gsub('default',size).gsub('%size',size)
  end

  def self.gdata_url token
    "https://gdata.youtube.com/feeds/api/videos/#{token}?v=2&alt=json"
  end

  def self.response_body url
    REQUEST.response_body(url)
  end

  def self.get_gdata token
    url     = Youtube.gdata_url(token)
    # begin
      body  = Youtube.response_body url
      hash  = JSON.parse(body)
      hash  = hash["entry"]
    # rescue
    #   return nil
    # end
    return hash
  end


  protected
  def collect_important_attrs
    self.yt_rating      = self.gdata['gd$rating']['average'].to_f
    self.max_rating     = self.gdata['gd$rating']['max'].to_i
    self.min_rating     = self.gdata['gd$rating']['min'].to_i
    self.view_count     = self.gdata['yt$statistics']['viewCount'].to_i
    self.favorite_count = self.gdata['yt$statistics']['favoriteCount'].to_i
    self.title          = self.gdata['title']['$t']
    self.yt_published   = self.gdata['published']['$t']

    _thumb_url
    _rating_100
  end

end