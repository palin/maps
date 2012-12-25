# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :name, :login, :email, :date_of_birth

  acts_as_authentic
end
