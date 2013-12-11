# -*- encoding : utf-8 -*-
require 'spec_helper'

describe V1::AbusesController do
  render_views

  let!(:report) { create(:report) }

  context "#create" do
    subject { post :create, format: :json, report_id: report.id, abuse: { name: name } }

    describe "correct parameters" do
      context "duplicate" do
        let(:name) { "duplicate" }

        its(:status) { should == 200 }
      end

      context "content" do
        let(:name) { "content" }

        its(:status) { should == 200 }
      end

      context "solved" do
        let(:name) { "solved" }

        its(:status) { should == 200 }
      end

      context "spam" do
        let(:name) { "spam" }

        its(:status) { should == 200 }
      end

      context "response body" do
        let(:name) { "spam" }
        let(:data) { MultiJson.load(subject.body) }

        it { data.length.should == 5 }
        it { data['name'].should == "spam" }
        it { data['report_id'].should == report.id }
      end
    end

    describe "incorrect parameters" do
      let(:name) { "" }

      its(:status) { should == 422 }
    end
  end
end
