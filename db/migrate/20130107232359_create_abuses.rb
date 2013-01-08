class CreateAbuses < ActiveRecord::Migration
  def change
    create_table :abuses do |t|

      t.timestamps
    end
  end
end
