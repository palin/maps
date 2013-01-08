class AddReportIdToAbuses < ActiveRecord::Migration
  def change
    add_column :abuses, :report_id, :integer
  end
end
