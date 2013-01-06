class OpinionDecorator < Draper::Base
  decorates :opinion

  def initialize(opinion, options ={})
    @opinion = opinion
    as_json
  end

  def as_json(options={})
    properties = {}
    properties[:id] = @opinion.id
    properties[:report_id] = @opinion.report.id
    properties[:title] = @opinion.title
    properties[:description] = @opinion.description
    properties[:rating] = @opinion.rating

    Hash[properties]
  end
end
