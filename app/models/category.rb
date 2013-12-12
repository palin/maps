# -*- encoding : utf-8 -*-
class Category < ActiveRecord::Base

  validates_presence_of :title, :description

  has_many :reports

  def image
    "categories/#{unique_id}.png"
  end
end
