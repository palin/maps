# -*- encoding : utf-8 -*-
class Api::AbusesController < Api::ApiController

  before_filter :find_report

  METHODS = [:spam, :duplicate, :content, :solved]

  METHOD_TO_TEXT = {
    METHODS[0] => "spamie",
    METHODS[1] => "duplikacie",
    METHODS[2] => "nieodpowiedniej treści",
    METHODS[3] => "rozwiązaniu problemu"
  }

  METHODS.each do |m|
    define_method(m) do
      @report.abuses << Abuse.new(:name => m.to_s)
      render_json :thanks => "Informacja o #{METHOD_TO_TEXT[m]} została wysłana do moderatorów."
    end
  end

  private

  def find_report
    @report = Report.find_by_id(params[:report_id])
  end
end
