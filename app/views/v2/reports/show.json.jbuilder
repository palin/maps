json.extract! report, :id, :title, :description, :positives, :negatives, :created_at, :updated_at, :category_id, :latitude, :longitude, :photo_data
json.photo do
  json.full report.photo_full
  json.medium report.photo_medium
  json.small report.photo_small
  json.thumb report.photo_thumb
end
json.category do
  json.unique_id report.category.unique_id
end
