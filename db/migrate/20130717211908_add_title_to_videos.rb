class AddTitleToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :yt_title, :string
  end
end
