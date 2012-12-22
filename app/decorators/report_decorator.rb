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
    properties[:category] = Category.find_by_id(@report.category_id).title
    properties[:latitude] = @report.latitude
    properties[:longitude] = @report.longitude
    properties[:rating] = @report.rating
    properties[:photo_full] = @report.photo.full.url
    properties[:photo_medium] = @report.photo.medium.url
    properties[:photo_small] = @report.photo.small.url
    properties[:photo_thumb] = @report.photo.thumb.url

    Hash[properties]
  end
end
