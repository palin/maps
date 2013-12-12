# -*- encoding : utf-8 -*-
require 'spec_helper'

describe V1::ReportsController do
  Fog.mock!
  render_views

  let(:category) { create :category }
  let(:data) { MultiJson.load(subject.body) }

  context "#create" do
    subject { post :create, format: :json, report: report }

    describe "correct parameters" do
      let(:report) { attributes_for(:report).merge!(category_id: category.id) }

      its(:status) { should == 200 }

      it { expect { subject }.to change { Report.count }.by(1) }

      context "response data" do
        it { data.length.should == 12 }
        it { data['title'].should == report[:title] }
        it { data['description'].should == report[:description] }
      end
    end

    describe "incorrect parameters" do
      let(:report) { attributes_for(:report) }

      its(:status) { should == 422 }
      it { expect { subject }.not_to change { Report.count }.by(1) }
    end

  end

  context "#index" do
    subject { get :index, format: :json }

    let(:data) { MultiJson.load(subject.body)["reports"] }

    describe "no reports" do
      it { data.should == [] }
    end

    describe "reports exist" do
      let!(:report) { create(:report) }
      let!(:report_2) { create(:report) }

      it { data[0]["id"].should == report.id }
      it { data[0]["latitude"].should == report.latitude.to_s }
      it { data[0]["longitude"].should == report.longitude.to_s }
      it { data[0]["category"]["unique_id"].should == report.category.unique_id }
      it { data[1]["id"].should == report_2.id }
      it { data[1]["latitude"].should == report_2.latitude.to_s }
      it { data[1]["longitude"].should == report_2.longitude.to_s }
      it { data[1]["category"]["unique_id"].should == report_2.category.unique_id }
    end
  end

  context "#update" do
    let!(:report) { create(:report) }

    subject { put :update, format: :json, id: report.id, report: { key: key } }

    describe "turned on cookies" do
      before { request.cookies["_reporter_session"] = "aaa" }

      context "with existing cookie" do
        before { request.cookies["report_id_#{report.id}"] = "1" }

        context "rating up" do
          let(:key) { "positives" }

          it { expect { subject }.not_to change { report.reload.positives }.to(1) }
          its(:status) { should == 403 }
        end

        context "rating down" do
          let(:key) { "negatives" }

          it { expect { subject }.not_to change { report.reload.negatives }.to(1) }
          its(:status) { should == 403 }
        end
      end

      context "without existing cookie" do
        context "rating up" do
          let(:key) { "positives" }

          it { expect { subject }.to change { report.reload.positives }.to(1) }
        end

        context "rating down" do
          let(:key) { "negatives" }

          it { expect { subject }.to change { report.reload.negatives }.to(1) }
        end
      end
    end

    describe "turned off cookies" do
      let(:key) { nil }

      before { request.cookies["_reporter_session"] = nil }

      its(:status) { should == 403 }
    end
  end

  context "#show" do
    let!(:report) { create(:report) }
    let!(:report_2) { create(:report) }

    subject { get :show, id: report.id, format: :json }

    context "report" do
      it { data["id"].should == report.id }
      it { data["title"].should == report.title }
      it { data["description"].should == report.description }
      it { data["rating"].should == report.rating }
    end
  end
end
