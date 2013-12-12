# -*- encoding : utf-8 -*-
require 'spec_helper'

describe User do
  it "has a valid factory" do
    build(:user).should be_valid
  end

  it "is invalid without name" do
    build(:user, name: nil).should be_invalid
  end

  it "is invalid without login" do
    build(:user, login: nil).should be_invalid
  end

  it "is invalid without password" do
    build(:user, password: nil).should be_invalid
  end

  it "is invalid without password_confirmation" do
    build(:user, password_confirmation: nil).should be_invalid
  end

  it "is invalid without email" do
    build(:user, email: nil).should be_invalid
  end
end
