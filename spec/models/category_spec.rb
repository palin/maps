# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Category do
  describe "factories" do
    it "has a valid factory" do
      build(:category).should be_valid
    end

    it "is invalid without title" do
      build(:category, title: nil).should be_invalid
    end

    it "is invalid without description" do
      build(:category, description: nil).should be_invalid
    end
  end

  describe "#image" do
    subject { create(:category, unique_id: "uid") }

    its(:image) { should == "categories/uid.png" }
  end
end
