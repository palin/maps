json.extract! @report, :id, :title, :description, :latitude, :longitude, :rating, :positives, :negatives
json.created_at @report.created_at.to_formatted_s(:db)
json.can_vote @can_vote
json.category do |json|
  json.title @report.category.title
  json.unique_id @report.category.unique_id
end
json.photo do |json|
  json.full @report.photo.full.url
  json.small @report.photo.small.url
end

if @report.opinions
  json.opinions(@report.opinions) do |json, opinion|
    json.extract! opinion, :id, :report_id, :title, :description, :rating
    json.can_vote !@disabled_opinions.include?(opinion.id)
  end
end