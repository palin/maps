class AddUniqueIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :unique_id, :string, :limit => 3
  end
end
