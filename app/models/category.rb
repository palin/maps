# -*- encoding : utf-8 -*-
class Category < ActiveRecord::Base
  attr_accessible :title, :description

  validates_presence_of :title, :description

  has_many :reports

  scope :without_reports, joins(:reports).where{ id.eq nil }
  scope :with_reports,    joins(:reports).where{ id.not_eq nil }
end
