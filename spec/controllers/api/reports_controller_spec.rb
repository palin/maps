# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Api::ReportsController do
  Fog.mock!

  let(:data) { JSON.parse(subject.body) }

  context "#send_report" do
    let(:report) { FactoryGirl.build(:report) }

    subject { post :send_report, :report => report, :format => :json }

    describe "correct params" do
      before { Report.stubs(:build_from_params).returns(report) }

      its(:code) { should == "200" }
      it { data["success"].should == true }
      it {
        expect { subject }.to change(Report, :count).by(1)
      }
    end

    describe "incorrect params" do
      let(:report) { {} }

      before { Report.stubs(:build_from_params).returns(nil) }

      its(:code) { should == "403" }
      it { data["success"].should == true }
    end
  end

  context "#all" do
    subject { get :all }

    let(:data) { JSON.parse(subject.body) }

    describe "no reports" do
      it { data["success"].should == true }
      it { data["reports"].should == [] }
    end

    describe "report exists" do
      let!(:report) { FactoryGirl.create(:report) }

      it { data["reports"][0]["id"].should == report.id }
    end
  end

  describe "rating" do
    let!(:report) { FactoryGirl.create(:report) }

    before { request.cookies["_reporter_session"] = "aaa" }

    context "#rate_up" do
      subject { post :rate_up, :id => report.id }

      it {
        expect { subject }.to change { report.reload.positives }.to(1)
      }
    end

    context "#rate_down" do
      subject { post :rate_down, :id => report.id }

      it {
        expect { subject }.to change { report.reload.negatives }.to(1)
      }
    end
  end

  context "#can_vote" do
    let!(:report) { FactoryGirl.create(:report) }

    subject { post :can_vote, :id => report.id }

    describe "no cookies set" do
      its(:status) { should == 200 }
    end

    describe "cookies set" do
      before { cookies["report_id_#{report.id}"] = report.id }

      its(:status) { should == 409 }
    end
  end
end
