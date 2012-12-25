class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.string :title
      t.string :description
      t.integer :positives
      t.integer :negatives

      t.timestamps
    end
  end
end
