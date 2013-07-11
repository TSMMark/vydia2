module TrackerHelper

  def tracking_url(video, network, type=:impression)
    segment = type==:view ? 'v' : 'i'
    "/#{segment}/#{video.token}/#{network.token}"
  end

  def tracking_pixel(video, network, type=:impression, *params)
    url     = tracking_url(video, network, type)
    image_tag(url, *params)
  end

end
