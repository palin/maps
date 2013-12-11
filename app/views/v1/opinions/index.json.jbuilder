json.opinions opinions do |opinion|
  json.extract! opinion, :id, :title, :description, :report_id
  json.rating opinion.rating
  json.can_vote !has_cookie?('opinion', opinion.id)
end
