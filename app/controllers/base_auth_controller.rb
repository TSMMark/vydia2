class BaseAuthController < ApplicationController

  before_filter :verify_login

  private

  def verify_login
    return if signed_in?
    redirect_to root_url
  end

end
