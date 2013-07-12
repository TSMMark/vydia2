class TrackerController < ApplicationController
  respond_to :html, :json

  before_filter :default_format
  before_filter :load_resources
  before_filter :get_ip
  before_filter :existing_impression

  def impression
    if @video && @network then
      @impression = Impression.new do |imp|
        imp.video_id    = @video.id
        imp.network_id  = @network.id
        imp.ip_address  = @ip_address
        imp.request_url = request.env['REQUEST_URI']
        imp.referer     = request.env['HTTP_REFERER']
        imp.user_agent  = request.env['HTTP_USER_AGENT']
      end 
      
      @impression.save!
    end
    
    render_blank_pixel
  end

  def view
    state = params[:state].to_i
    state = [state, 0].max
    state = [state, 4].min

    unless @impression.blank?
      play = @impression.play || Play.generate(@impression)
      play.state = state if (!play.state || state >= play.state)
      @impression.play = play
      play.save
      @impression.save
    end

    render_blank_pixel
  end




  protected

  def default_format
    request.format = "json" unless params[:format]
  end
  
  def get_ip
    @ip_address = request.remote_ip
  end

  def load_resources
    @video      = Video.find_by_token params[:id]
    @network    = Network.find_by_token params[:network_id]
  end

  def existing_impression
    unless @video.blank? || @network.blank?
      @impression = Impression.where(
        video_id:   @video.id,
        network_id: @network.id,
        ip_address: @ip_address
      ).last
    else
      @impression = nil
    end
  end


end
