class Report < ActiveRecord::Base
  attr_accessible :title, :description, :photo, :category_id, :latitude, :longitude

  belongs_to :category
  has_many :opinions
  has_many :abuses, :class_name => "Abuse"

  mount_uploader :photo, PhotoUploader

  validates_presence_of :title, :description, :category_id, :latitude, :longitude, :photo
  validates_numericality_of :latitude, :longitude
  validates_format_of :title, :with => /^.{8,30}$/
  validates_format_of :description, :with => /^.{15,120}$/

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

    Report.new(data)
  end

  def rating
    positives - negatives
  end
end
