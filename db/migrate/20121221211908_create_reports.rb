class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :title
      t.string :description
      t.string :photo
      t.integer :positives, :default => 0
      t.integer :negatives, :default => 0

      t.timestamps
    end
  end
end
