class TrackerController < ApplicationController

  def pixel
    params[:id]
    params[:player]
    render_blank_pixel
  end

end
