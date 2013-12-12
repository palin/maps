class RemoveTitleAndDescriptionFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :title, :string
    remove_column :categories, :description, :string
  end
end
