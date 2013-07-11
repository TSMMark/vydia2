class UsersController < BaseAuthController

  def index
    @users = User.all
    # raise @users.to_yaml
  end

  def show
    @user   = User.find(params[:id])
    @videos = @user.videos
  end

end
