json.reports reports do |report|
  json.extract! report, :id, :title, :description, :photo, :positives, :negatives, :created_at, :updated_at, :category_id, :latitude, :longitude, :photo_data
  json.category do
    json.unique_id report.category.unique_id
  end
end
