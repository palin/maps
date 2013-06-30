# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Category do
  let(:unique_id) { "uid" }

  describe "factories" do
    it "has a valid factory" do
      FactoryGirl.build(:category).should be_valid
    end

    it "is invalid without title" do
      FactoryGirl.build(:category, title: nil).should be_invalid
    end

    it "is invalid without description" do
      FactoryGirl.build(:category, description: nil).should be_invalid
    end
  end

  describe "#image" do
    let(:category) { FactoryGirl.create(:category, unique_id: unique_id) }

    it { category.image.should == "categories/uid.png" }
  end

  describe "self#find_category_id" do
    subject { Category.find_category_id(unique_id) }

    context "existing category" do
      let!(:category) { FactoryGirl.create(:category, unique_id: unique_id) }

      it { should == category.id }
    end

    context "nonexistent category" do
      let(:unique_id) { "any" }

      it { should == nil }
    end
  end
end