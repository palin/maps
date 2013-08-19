json.array! @reports do |report|
  json.extract! report, :id, :latitude, :longitude
  json.category do |json|
    json.unique_id report.category.unique_id
  end
end