class VideosController < BaseAuthController
  include VideosHelper

  skip_before_filter :verify_login, only: :embed
  
  def embed
    @video    = params[:id] && Video.find(params[:id])
    # @blog   = Blog.find params[:player]
    @network  = params[:network_id] && Network.find(params[:network_id])

    if @video && @network
      render layout: 'layouts/app_embed'
    else
      render 'errors/404', layout:'layouts/embed_error'
    end

  end

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])

    @networks = @video.networks

    @impressions = @video.impressions

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    @video = Video.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
    @video.token = link_from_token @video.token
    
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(params[:video]) do |v|
      v.user = current_user
      v.token = token_from_link v.token
    end

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render json: @video, status: :created, location: @video }
      else
        format.html { render action: "new" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end
end
