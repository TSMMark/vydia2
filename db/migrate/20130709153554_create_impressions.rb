class CreateImpressions < ActiveRecord::Migration
  def change
    create_table :impressions do |t|
      t.integer :video_id
      t.integer :network_id
      t.string :ip_address, limit: 16
      t.string :request_url, limit: 200
      t.string :referer, limit: 200
      t.string :user_agent, limit: 200

      t.timestamps
    end
  end
end
