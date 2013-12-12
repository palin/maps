# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Category do
  subject { create(:category, unique_id: "uid") }

  describe "factories" do
    it "has a valid factory" do
      build(:category).should be_valid
    end
  end

  describe "#image" do
    its(:image) { should == "categories/uid.png" }
  end

  describe "#title" do
    its(:title) { should_not be_empty }
  end

  describe "#description" do
    its(:description) { should_not be_empty }
  end
end
