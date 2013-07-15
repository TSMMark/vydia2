class PagesController < ApplicationController
  skip_before_filter :verify_login, only: :home
  
  def home
    @vydia_earnings = Money.new(Network.vydia_revenue).with_symbol
  end

  def about
  end
end
