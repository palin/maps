# -*- encoding : utf-8 -*-
class Api::AbusesController < Api::ApiController

  before_filter :find_report_by_id

  def spam
    @report.abuses << Abuse.new(:name => "spam")

    render_json :thanks => "Informacja o spamie została wysłana do moderatorów."
  end

  def duplicate
    @report.abuses << Abuse.new(:name => "duplicate")

    render_json :thanks => "Informacja o duplikacie została wysłana do moderatorów."
  end

  def content
    @report.abuses << Abuse.new(:name => "content")

    render_json :thanks => "Informacja o nieodpowiedniej treści została wysłana do moderatorów."
  end

  def solved
    @report.abuses << Abuse.new(:name => "solved")

    render_json :thanks => "Informacja o rozwiązaniu problemu została wysłana do moderatorów."
  end

  private

  def find_report_by_id
    @report = Report.find_by_id(params[:report_id])
  end
end
