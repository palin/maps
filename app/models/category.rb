# -*- encoding : utf-8 -*-
class Category < ActiveRecord::Base

  validates_presence_of :title, :description

  has_many :reports

  def image
    "categories/#{unique_id}.png"
  end

  def self.find_category_id(uid)
    category = Category.find_by_unique_id(uid)
    category.present? ? category.id : nil
  end
end
