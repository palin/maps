# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Abuse do
  it "has a valid factory" do
    FactoryGirl.build(:abuse).should be_valid
  end

  it "is invalid without name" do
    FactoryGirl.build(:abuse, name: nil).should be_invalid
  end

  it "is invalid without report_id" do
    FactoryGirl.build(:abuse, report_id: nil).should be_invalid
  end

  describe "#reason" do
    let(:abuse_name) { "spam" }
    let(:abuse) { FactoryGirl.create(:abuse, name: abuse_name) }

    describe "for spam" do
      it { abuse.reason.should == "Spam" }
    end

    describe "for duplicate" do
      let(:abuse_name) { "duplicate" }

      it { abuse.reason.should == "Duplikat" }
    end

    describe "for solved" do
      let(:abuse_name) { "solved" }

      it { abuse.reason.should == "Problem rozwiązano" }
    end

    describe "for content" do
      let(:abuse_name) { "content" }

      it { abuse.reason.should == "Nieodpowiednia treść" }
    end

    describe "for noname" do
      let(:abuse_name) { "noname" }

      it { abuse.reason.should == "Brak powodu" }
    end
  end
end