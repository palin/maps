json.opinions opinions do |opinion|
  json.extract! opinion, :id, :title, :description, :positives, :negatives, :created_at, :updated_at, :report_id
end
