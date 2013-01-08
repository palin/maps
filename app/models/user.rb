# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :name, :login, :email, :date_of_birth

  validates_presence_of :login, :password, :password_confirmation

  acts_as_authentic
end
