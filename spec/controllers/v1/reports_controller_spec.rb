# -*- encoding : utf-8 -*-
require 'spec_helper'

describe V1::ReportsController do
  Fog.mock!
  render_views

  let(:data) { MultiJson.load(subject.body) }

  context "#send_report" do
    let(:report) { build(:report) }

    subject { post :send_report, report: report, format: :json }

    describe "correct params" do
      before { Report.stub(:build_from_params).and_return(report) }

      its(:status) { should == 200 }
      it { data["success"].should == true }
      it { expect { subject }.to change(Report, :count).by(1) }
    end

    describe "incorrect params" do
      let(:report) { {} }

      before { Report.stub(:build_from_params).and_return(nil) }

      its(:status) { should == 403 }
      it { data["success"].should == true }
    end
  end

  context "#index" do
    subject { get :index, format: :json }

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

    subject { put :update, id: report.id, rating: rating, format: :json}

    before { request.cookies["_reporter_session"] = "aaa" }

    context "didn't voted before" do
      context "rate up" do
        let(:rating) { "up" }

        it { expect { subject }.to change { report.reload.positives }.to(1) }
      end

      context "rate down" do
        let(:rating) { "down" }

        it { expect { subject }.to change { report.reload.negatives }.to(1) }
      end
    end

    context "voted before" do
      before { request.cookies["report_id_#{report.id}"] = "1" }

      context "rate up" do
        let(:rating) { "up" }

        it { expect { subject }.not_to change { report.reload.positives }.to(1) }
        its(:status) { should == 404 }
      end

      context "rate down" do
        let(:rating) { "down" }

        it { expect { subject }.not_to change { report.reload.negatives }.to(1) }
        its(:status) { should == 404 }
      end
    end

    context "no param" do
      describe "empty" do
        let(:rating) { "" }

        its(:status) { should == 404 }
      end

      describe "nil" do
        let(:rating) { nil }

        its(:status) { should == 404 }
      end
    end
  end

  context "#show" do
    let!(:report) { create(:report) }
    let!(:report_2) { create(:report) }

    subject { get :show, id: report.id, format: :json }

    context "report" do
      it { data["id"].should == report.id }
      it { data["description"].should == report.description }
      it { data["created_at"].should == report.created_at.to_formatted_s(:db) }
      it { data["can_vote"].should == true }

      context "can not vote" do
        before { request.cookies["report_id_#{report.id}"] = "1" }

        it { data["can_vote"].should == false }
      end
    end
  end
end
