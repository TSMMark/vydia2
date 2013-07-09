module VideosHelper

  def token_from_link(url)
    if url[/youtu\.be\/([^\?]*)/]
      @token = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      
      @token = $5
    end

    @token
  end

  def link_from_token(token=@token, type=:link)
    @token = token
    return  case type
            when :swf
               "//www.youtube.com/v/#{token}?enablejsapi=1&playerapiid=ytplayer&version=3"
            else
              "https://www.youtube.com/watch?v=#{@token}"
            end
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
