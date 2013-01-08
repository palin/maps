class FixAbusesColumnsNames < ActiveRecord::Migration
  def up
    rename_column :abuses, :type, :name
  end

  def down
  end
end
