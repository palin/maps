class OpinionDecorator < Draper::Base
  decorates :opinion

  def self.decorate(opinions, options={})
    @opinions = opinions
    @disable_for = options

    self.as_json
  end

  def self.as_json(options={})
    @opinions.each do |opinion|
      {
        :id => opinion.id,
        :report_id => opinion.report.id,
        :title => opinion.title,
        :description => opinion.description,
        :rating => opinion.rating,
        :can_vote => "false"
      }
    end
  end
end
