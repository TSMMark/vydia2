class AddIndexesToPlays < ActiveRecord::Migration
  def change
    add_index :plays, :impression_id, unique: true
    add_index :plays, :state
  end
end
