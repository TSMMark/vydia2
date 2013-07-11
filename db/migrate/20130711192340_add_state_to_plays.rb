class AddStateToPlays < ActiveRecord::Migration
  def change
    add_column :plays, :state, :integer
  end
end
