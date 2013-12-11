json.extract! opinion, :id, :title, :description, :report_id, :rating
json.can_vote !has_cookie?('opinion', opinion.id)
