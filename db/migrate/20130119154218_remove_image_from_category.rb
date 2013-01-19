class RemoveImageFromCategory < ActiveRecord::Migration
  def up
    remove_column :categories, :image
  end

  def down
  end
end
