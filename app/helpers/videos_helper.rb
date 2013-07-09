module VideosHelper

  def id_from_link(url)
    if url[/youtu\.be\/([^\?]*)/]
      @video_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      
      @video_id = $5
    end

    @video_id
  end

  def link_from_id(video_id=@video_id)
    @video_id = video_id
    "https://www.youtube.com/watch?v=#{@video_id}"
  end

  def swf_link_of_id(video_id=@video_id)
    @video_id = video_id
    "//www.youtube.com/v/#{video_id}?enablejsapi=1&playerapiid=ytplayer&version=3"
  end
  
  # incomplete
  # def embed_code(url, method=:swf)
  #   video_id_of_url url
  #   case method
  #   when :swf
  #     %Q{<div></div>}
  #   when :iframe
  #     %Q{<iframe title="YouTube video player" width="640" height="390" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
  #   end
  # end

end
