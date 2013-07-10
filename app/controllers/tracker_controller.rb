class TrackerController < ApplicationController

  before_filter :default_format
  def default_format
    request.format = "json" unless params[:format]
  end

  respond_to :html, :json

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
    render_blank_pixel
  end

  def view
    @video    = Video.find params[:id]
    @network  = Network.find params[:network_id]

    respond_with @video


  end

end
