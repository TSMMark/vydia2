class AddIndexes < ActiveRecord::Migration
  def change
    add_index :videos, :token, :unique => true

    add_index :networks, :token, :unique => true

    add_index :impressions, :video_id
    add_index :impressions, :network_id
    add_index :impressions, :ip_address
    add_index :impressions, :created_at
  end
end
