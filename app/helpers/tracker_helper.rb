module TrackerHelper
  def tracking_pixel(video, network, *params)
    image_tag("/t/#{video.video_id}/#{network.token}", *params)
  end
end
