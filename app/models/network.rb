class Network < BaseModel
  attr_accessible :name

  validates_presence_of :name

  uniquify :token do
    generate_token
  end

  has_many :impressions, inverse_of: :network
  has_many :videos, through: :impressions


  # find by internal id or youtube video_id
  def self.find(id)
    if !id || "#{id}".numeric?
      return super id
    else
      return find_by_token id
    end
  end

  def videos
    super.group('videos.id')
  end

  def count_videos
    videos.count.count
  end

  # an impression occurs every time an embed iframe is loaded
  def impressions video=nil, o={}
    o[:unique] = true if o[:unique].nil?
    i = super()
    i = i.where(video_id: video.id) if video
    i = i.select('DISTINCT video_id, ip_address') if o[:unique]
    i
  end
  def count_impressions video=nil, o={}
    i = self.impressions video, o
    i.count
  end

  # plays occur when someone clicks the video in an embed
  #   to begin playing of the video
  def plays video=nil, o={}
    o[:min_state] = Play.default_min_state if o[:min_state].nil?
    o[:max_state] = Play.default_max_state if o[:max_state].nil?
    o[:min_state] = [o[:max_state], o[:min_state]].min
    i = self.impressions(video, o).joins(:play)
    i.where("state >= ? AND state <= ?", o[:min_state], o[:max_state])
  end
  def count_plays video=nil, o={}
    plays(video, o).count
  end

  # a view = total plays >= 25%, not unique
  def views video=nil
    plays video, unique: false
  end
  # count_views is what is used in CPM calculation
  def count_views video=nil
    views(video).count
  end


  # amount of money a network has made on vydia
  #   total of all network's video_revenue added up
  def revenue
    sum = 0
    videos.all.each do |v|
      sum += video_revenue(v)
    end
    sum
  end

  # amount of money a video has brought in for this network
  def video_revenue video, views = nil
    views ||= count_views(video)
    Network.cpm_formula(offered_cpm(video.cpm), views)
  end

  def vydia_revenue
    revenue / split_keep * vydia_keep
  end
  
  # CPM the network keeps
  def offered_cpm bid_cpm
    bid_cpm * split_keep
  end
  
  # CPM Vydia keeps
  def vydia_cpm bid_cpm
    bid_cpm * (1 - split_keep)
  end

  # define ratio ( 1 == network keeps 100% and Vydia keeps 0% )
  def split_keep
    Network.default_split
  end
  def vydia_keep
    (1 - split_keep)
  end

  # Class Methods
  def self.cpm_formula cpm, views
    views.to_f / Money.one_thousand * cpm
  end

  # calculate total Vydia revenue
  def self.vydia_revenue
    sum = 0
    Network.all.each do |n|
      r    = n.vydia_revenue
      sum += r
    end
    sum
  end
  
  # CPM the network keeps
  def self.offered_cpm bid_cpm
    bid_cpm.to_f * default_split
  end
  def self.default_split
    0.50
  end


  # generate a random token via uuid
  def self.generate_token
    # make sure the token has non-digit characters
    #   this prevents find(id) from getting confused
    begin
      token = SecureRandom.uuid.split('-').first
    end while token.numeric?
    token
  end


end
