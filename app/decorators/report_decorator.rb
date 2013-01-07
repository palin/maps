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
    properties[:photo_medium] = @report.photo.medium.url
    properties[:photo_small] = @report.photo.small.url
    properties[:photo_thumb] = @report.photo.thumb.url
    properties[:rate_up_path] = "/api/reports/rate_up"
    properties[:rate_down_path] = "/api/reports/rate_down"

    Hash[properties]
  end
end
