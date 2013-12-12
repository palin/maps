# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Report do
  context "validations" do
    it "has a valid factory" do
      build(:report).should be_valid
    end

    describe "title" do
      it "is invalid without value" do
        build(:report, title: nil).should be_invalid
      end

      it "is too short" do
        build(:report, title: "a"*7).should be_invalid
      end

      it "is too long" do
        build(:report, title: "a"*31).should be_invalid
      end

      it "is valid between 8 and 30 characters" do
        build(:report, title: "a"*15).should be_valid
      end
    end

    describe "description" do
      it "is invalid without value" do
        build(:report, description: nil).should be_invalid
      end

      it "is too short" do
        build(:report, description: "a"*14).should be_invalid
      end

      it "is too long" do
        build(:report, description: "a"*121).should be_invalid
      end

      it "is valid between 15 and 120 characters" do
        build(:report, description: "a"*60).should be_valid
      end
    end

    describe "category_id" do
      it "is invalid without value" do
        build(:report, category_id: nil).should be_invalid
      end

      it "is invalid with integer id" do
        build(:report, category_id: 123).should be_valid
      end
    end

    describe "latitude" do
      it "is invalid without value" do
        build(:report, latitude: nil).should be_invalid
      end

      it "is invalid with invalid value" do
        build(:report, latitude: 'abc.xyz').should be_invalid
      end

      it "is valid with float value" do
        build(:report, latitude: 123.123123).should be_valid
      end
    end

    describe "longitude" do
      it "is invalid without longitude" do
        build(:report, longitude: nil).should be_invalid
      end

      it "is invalid with invalid longitude" do
        build(:report, longitude: 'abc.xyz').should be_invalid
      end

      it "is valid with float value" do
        build(:report, longitude: 123.123123).should be_valid
      end
    end

    describe "photo" do
      it "is invalid without value" do
        build(:report, photo: nil).should be_invalid
      end
    end
  end

  context "#rating" do
    let(:report) { build :report, positives: positives, negatives: negatives }

    subject { report.rating }

    describe "equal" do
      let(:positives) { 5 }
      let(:negatives) { 5 }

      it { should == 0 }
    end

    describe "negative" do
      let(:positives) { 5 }
      let(:negatives) { 10 }

      it { should == -5 }
    end

    describe "positive" do
      let(:positives) { 10 }
      let(:negatives) { 5 }

      it { should == 5 }
    end
  end

  context "#rate!" do
    let(:report) { create :report }

    subject { report.rate!(key) }

    describe "negatively" do
      let(:key) { 'negatives' }

      it { should == true }
      it { expect { subject }.to change { report.rating }.by(-1) }
    end

    describe "positively" do
      let(:key) { 'positives' }

      it { should == true }
      it { expect { subject }.to change { report.rating }.by(1) }
    end

    describe "no key" do
      let(:key) { '' }

      it { should == nil }
      it { expect { subject }.not_to change { report.rating } }
    end
  end
end
