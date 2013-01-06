class OpinionDecorator < Draper::Base
  decorates :opinion

  def initialize(opinion, options ={})
    @opinion = opinion
    as_json
  end

  def as_json(options={})
    properties = {}
    properties[:title] = @opinion.title
    properties[:description] = @opinion.description
    properties[:created_at] = @opinion.created_at
    properties[:rating] = @opinion.rating
    properties[:opinion_up_path] = "/api/opinions/rate_up"
    properties[:opinion_down_path] = "/api/opinions/rate_down"

    Hash[properties]
  end
end
