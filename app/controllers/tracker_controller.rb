class TrackerController < ApplicationController

  def pixel
    @video      = Video.find params[:id]
    @network    = Network.find params[:network_id]

    ip_address  = request.remote_ip

    if @video && @network then
      @impression = Impression.new do |imp|
        imp.video_id    = @video.id
        imp.network_id  = @network.id
        imp.ip_address  = ip_address
        imp.request_url = request.env['REQUEST_URI']
        imp.referer     = request.env['HTTP_REFERER']
        imp.user_agent  = request.env['HTTP_USER_AGENT']
      end 
      
      @impression.save!
    end

    # @request = {
    #   referer:      request.env['HTTP_REFERER'],
    #   user_agent:   request.env['HTTP_USER_AGENT'],
    #   request_url:  request.env['REQUEST_URI'],
    #   ip_address:   request.remote_ip
    # }

    # @request.ryaml

    render_blank_pixel
  end

end
