class PagesController < ApplicationController
  skip_before_filter :verify_login, only: :home
  
  def home
  end

  def about
  end
end
