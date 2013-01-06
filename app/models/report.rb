# -*- encoding : utf-8 -*-
class Report < ActiveRecord::Base
  attr_accessible :title, :description, :photo, :category_id, :latitude, :longitude

  belongs_to :category
  has_many :opinions

  mount_uploader :photo, PhotoUploader

  validates_presence_of :title, :description, :category_id, :latitude, :longitude, :photo
  validates_numericality_of :latitude, :longitude
  validates_format_of :title, :with => /^[a-zA-Z0-9\s-]{8,30}+$/
  validates_format_of :description, :with => /^[a-zA-Z0-9\s[-,._\(\)]*]{15,120}$/

  REPORT_ATTRS = [:title, :description, :photo, :category_id, :latitude, :longitude]

  def self.build_from_params(params)
    data = {}

    REPORT_ATTRS.each do |att|
      if att == :category_id
        category = Category.find_by_unique_id(params[att])
        data[att] = category.id
      else
        data[att] = params[att]
      end
    end

    report = Report.new(data)
  end

  def rating
    positives - negatives
  end
end
