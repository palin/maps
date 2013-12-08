json.reports reports do |report|
  json.extract! report, :id, :latitude, :longitude
  json.category do
    json.unique_id report.category.unique_id
  end
end
