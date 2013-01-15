class ReportDecorator < Draper::Base
  decorates :report

  def initialize(report, options ={})
    @report = report
    as_json
  end

  def as_json(options={})
    properties = {}
    properties[:id] = @report.id
    properties[:title] = @report.title
    properties[:description] = @report.description
    properties[:category_title] = @report.category.title
    properties[:category_unique_id] = @report.category.unique_id
    properties[:latitude] = @report.latitude
    properties[:longitude] = @report.longitude
    properties[:rating] = @report.rating
    properties[:photo_full] = @report.photo.full.url
    properties[:photo_small] = @report.photo.small.url

    Hash[properties]
  end
end
