class AddPublishedToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :yt_published, :datetime
  end
end
