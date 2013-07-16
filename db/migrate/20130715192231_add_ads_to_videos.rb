class AddAdsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :ad_after, :string
    add_column :videos, :ad_bottom, :string
  end
end
