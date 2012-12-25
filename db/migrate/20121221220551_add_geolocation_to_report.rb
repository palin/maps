class AddGeolocationToReport < ActiveRecord::Migration
  def change
    add_column :reports, :latitude, :decimal, :precision => 8, :scale => 5
    add_column :reports, :longitude, :decimal, :precision => 8, :scale => 5
  end
end
