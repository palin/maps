class ReportDecorator < Draper::Base
  decorates :report

  def initialize(report, options ={})
    @report = report
    as_json
  end

  def as_json(options={})
    {
      :id => @report.id,
      :title => @report.title,
      :created_at => @report.created_at.to_formatted_s,
      :description => @report.description,
      :category_title => @report.category.title,
      :category_unique_id => @report.category.unique_id,
      :latitude => @report.latitude,
      :longitude => @report.longitude,
      :rating => @report.rating,
      :photo_full => @report.photo.full.url,
      :photo_small => @report.photo.small.url
    }
  end
end
