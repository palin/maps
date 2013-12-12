# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  validates_presence_of :name, :login, :password, :password_confirmation, :email

  acts_as_authentic
end
