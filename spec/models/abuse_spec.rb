# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Abuse do
  it "has a valid factory" do
    build(:abuse).should be_valid
  end

  it "is invalid without name" do
    build(:abuse, name: nil).should be_invalid
  end

  it "is invalid without report_id" do
    build(:abuse, report_id: nil).should be_invalid
  end

  describe "#reason" do
    let(:abuse_name) { "spam" }
    let(:abuse) { create(:abuse, name: abuse_name) }

    subject { abuse }

    describe "for spam" do
      its(:reason) { should == "Spam" }
    end

    describe "for duplicate" do
      let(:abuse_name) { "duplicate" }

      its(:reason) { should == "Duplikat" }
    end

    describe "for solved" do
      let(:abuse_name) { "solved" }

      its(:reason) { should == "Problem rozwiązano" }
    end

    describe "for content" do
      let(:abuse_name) { "content" }

      its(:reason) { should == "Nieodpowiednia treść" }
    end

    describe "for noname" do
      let(:abuse_name) { "noname" }

      its(:reason) { should == "Brak powodu" }
    end
  end
end
