class DropEventsTable < ActiveRecord::Migration
  def up
    drop_table :events
  end

  def down
  end
end
