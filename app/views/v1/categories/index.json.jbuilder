json.categories categories do |category|
  json.extract! category, :id, :unique_id, :title, :description
end
