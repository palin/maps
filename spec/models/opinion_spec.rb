# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Opinion do
  it "has a valid factory" do
    build(:opinion).should be_valid
  end

  it "is invalid without title" do
    build(:opinion, title: nil).should be_invalid
  end

  it "is invalid without description" do
    build(:opinion, description: nil).should be_invalid
  end

  it "is invalid without report_id" do
    build(:opinion, report_id: nil).should be_invalid
  end

  context "#rating" do
    let(:opinion) { build :opinion, positives: positives, negatives: negatives }

    subject { opinion.rating }

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
    let(:opinion) { create :opinion }

    subject { opinion.rate!(key) }

    describe "negatively" do
      let(:key) { 'negatives' }

      it { should == true }
      it { expect { subject }.to change { opinion.rating }.by(-1) }
    end

    describe "positively" do
      let(:key) { 'positives' }

      it { should == true }
      it { expect { subject }.to change { opinion.rating }.by(1) }
    end

    describe "no key" do
      let(:key) { '' }

      it { should == nil }
      it { expect { subject }.not_to change { opinion.rating } }
    end
  end
end
