class AddPhotoDataToReports < ActiveRecord::Migration
  def change
    add_column :reports, :photo_data, :text
  end
end
