class AddReportIdToOpinions < ActiveRecord::Migration
  def change
    add_column :opinions, :report_id, :integer
  end
end
