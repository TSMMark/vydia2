class ChangeLinkToId < ActiveRecord::Migration
  def change
    remove_column :videos, :link, :string
    add_column    :videos, :video_id, :string
  end
end
