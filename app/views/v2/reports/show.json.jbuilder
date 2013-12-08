json.extract! report, :id, :title, :description
json.rating report.rating
json.can_vote user_can_vote?
json.created_at report.created_at.to_formatted_s(:db)
json.photo do
  json.full report.photo_full
  json.small report.photo_small
end
json.category do
  json.title report.category.title
end
# json.partial! 'v2/opinions/opinion', opinions: report.opinions
