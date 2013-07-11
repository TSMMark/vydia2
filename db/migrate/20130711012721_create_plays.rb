class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.integer :impression_id

      t.integer :seconds_passed

      t.timestamps
    end
  end
end
