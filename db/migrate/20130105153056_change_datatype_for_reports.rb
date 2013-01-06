class ChangeDatatypeForReports < ActiveRecord::Migration
  def up
    change_table :reports do |t|
      t.change :latitude, :decimal, :precision => 8, :scale => 6
      t.change :longitude, :decimal, :precision => 8, :scale => 6
    end
  end

  def down
    change_table :reports do |t|
      t.change :latitude, :decimal, :precision => 8, :scale => 5
      t.change :longitude, :decimal, :precision => 8, :scale => 5
    end
  end
end
