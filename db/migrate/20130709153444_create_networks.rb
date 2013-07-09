class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.string :name
      t.string :token, limit: 12

      t.timestamps
    end
  end
end
