# -*- encoding : utf-8 -*-
class Category < ActiveRecord::Base

  validates_presence_of :unique_id
  has_many :reports

  def image
    "categories/#{unique_id}.png"
  end

  def title
    I18n.t("models.category.#{unique_id}.title")
  end

  def description
    I18n.t("models.category.#{unique_id}.description")
  end
end
