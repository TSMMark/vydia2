module VideosHelper

  def video_id(url){
    if youtube_url[/youtu\.be\/([^\?]*)/]
      return $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      return $5
    end

  }
  
  def embed_code(url, method=:swf)
    @video_id = video_id url
    case method
    when :swf
      %Q{}
    when :iframe
      %Q{<iframe title="YouTube video player" width="640" height="390" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
  end

end
