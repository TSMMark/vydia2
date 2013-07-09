class AddUseridToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :user_id, :int
    add_index :videos, :user_id, name: :video_user_id_index
  end
end
