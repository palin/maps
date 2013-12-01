class Opinion < ActiveRecord::Base
  belongs_to :report

  validates_presence_of :title, :description

  validates_format_of :title, with: /^.{3,15}$/, multiline: true
  validates_format_of :description, with: /^.{15,160}$/, multiline: true

  def rating
    positives - negatives
  end

  def rate!(key)
    increment!(key) if key.present?
  end
end
