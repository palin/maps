class Report < ActiveRecord::Base
  belongs_to :category
  has_many :opinions
  has_many :abuses, class_name: "Abuse"

  mount_uploader :photo, PhotoUploader

  validates_presence_of :title, :description, :category_id, :latitude, :longitude, :photo
  validates_numericality_of :latitude, :longitude
  validates_format_of :title, with: /^.{8,30}$/, multiline: true
  validates_format_of :description, with: /^.{15,120}$/, multiline: true

  REPORT_ATTRS = [:title, :description, :photo, :category_id, :latitude, :longitude]

  def rating
    positives - negatives
  end

  def rate!(key)
    increment!(key) if key.present?
  end

  [:full, :medium, :small, :thumb].each do |version|
    define_method "photo_#{version}" do
      photo.send(version).url.to_s
    end
  end
end
