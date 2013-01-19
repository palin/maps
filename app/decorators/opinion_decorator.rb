class OpinionDecorator < Draper::Base
  decorates :opinion

  def initialize(opinion, options ={})
    @opinion = opinion
    as_json
  end

  def as_json(options={})
    {
      :id => @opinion.id,
      :report_id => @opinion.report.id,
      :title => @opinion.title,
      :description => @opinion.description,
      :rating => @opinion.rating
    }
  end
end
