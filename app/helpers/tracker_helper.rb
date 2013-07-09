module TrackerHelper
  def tracking_pixel(video, network, *params)
    image_tag("/t/#{video.token}/#{network.token}", *params)
  end
end
