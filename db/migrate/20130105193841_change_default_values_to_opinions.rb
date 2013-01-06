class ChangeDefaultValuesToOpinions < ActiveRecord::Migration
  def up
    change_table :opinions do |t|
      t.change :positives, :integer, :default => 0
      t.change :negatives, :integer, :default => 0
    end
  end

  def down
    change_table :opinions do |t|
      t.change :positives, :integer, :default => nil
      t.change :negatives, :integer, :default => nil
    end
  end
end
