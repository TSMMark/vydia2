class AddMetadataToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :yt_rating, :float
    add_column :videos, :yt_view_count, :integer
    add_column :videos, :yt_favorite_count, :integer
    add_column :videos, :yt_thumb, :string
  end
end
