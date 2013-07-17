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
                :view_count, :favorite_count

  def initialize(token)
    self.token = token
    self.gdata = Youtube.get_gdata token
    self.collect_important_attrs
  end

  def collect_important_attrs
    self.yt_rating      = self.gdata["gd$rating"]["average"]
    self.max_rating     = self.gdata["gd$rating"]["max"]
    self.min_rating     = self.gdata["gd$rating"]["min"]
    self.view_count     = self.gdata["yt$statistics"]["viewCount"]
    self.favorite_count = self.gdata["yt$statistics"]["favoriteCount"]
    self.title          = self.gdata["title"]["$t"]

    _thumb_url
    _rating_100
  end

  def thumb size="default"
    Youtube.thumb(self.base_thumb_url, size)
  end
  def self.thumb url, size="default"
    # sizes = default, mqdefault, hqdefault, sddefault, start, middle, end
    url.gsub('%size',size)
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
  def self.gdata_url token
    URI.parse "https://gdata.youtube.com/feeds/api/videos/#{token}?v=2&alt=json"
  end

  def self.response_body url
    Net::HTTP.get_response(url).body
  end

  def self.get_gdata token
    url     = Youtube.gdata_url(token)
    begin
      body  = Youtube.response_body url
      hash  = JSON.parse(body)
      hash  = hash["entry"]
      puts hash
    rescue
      return nil
    end
    return hash
  end

end