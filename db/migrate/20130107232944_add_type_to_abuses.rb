class AddTypeToAbuses < ActiveRecord::Migration
  def change
    add_column :abuses, :type, :string
  end
end
