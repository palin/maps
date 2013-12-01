# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  validates_presence_of :login, :password, :password_confirmation

  acts_as_authentic
end
