class AddCpmToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :cpm, :float
  end
end
