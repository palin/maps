# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Api::ReportsController do
  Fog.mock!

  context "#send_report" do
    it "returns success if params correct" do
      r_count = Report.count
      report = FactoryGirl.build(:report)
      Report.stubs(:build_from_params).returns(report)

      post :send_report, :report => report, :format => :json

      Report.count.should == r_count + 1
      response.body.should == {:success => true}.to_json
      response.code.should == "200"
    end

    it "returns fail if no params" do
      Report.stubs(:build_from_params).returns(nil)
      post :send_report, :report => {}, :format => :json

      response.body.should == {:success => true}.to_json
      response.code.should == "403"
    end
  end

  context "#all" do
    it "renders empty json" do
      get :all

      response.body.should == {:success => true, :reports => []}.to_json
    end

    it "renders json with report's data" do
      @report = FactoryGirl.create(:report)

      get :all

      response.body.include?("{\"id\":#{@report.id}").should == true
    end
  end

  context "#rate_up" do
    it "increments positives of given report" do
      report = FactoryGirl.create(:report)
      request.cookies["_reporter_session"] = "aaa"

      post :rate_up, :id => report.id

      report.reload.positives.should == 1
    end
  end

  context "#rate_down" do
    it "increments negatives of given report" do
      report = FactoryGirl.create(:report)
      request.cookies["_reporter_session"] = "aaa"

      post :rate_down, :id => report.id

      report.reload.negatives.should == 1
    end
  end

  context "#can_vote" do
    it "returns 200 if has no cookies set" do
      @report = FactoryGirl.create(:report)

      post :can_vote, :id => @report.id

      response.status.should == 200
    end

    it "returns 409 if has cookies set" do
      @report = FactoryGirl.create(:report)
      cookies["report_id_#{@report.id}"] = @report.id
      post :can_vote, :id => @report.id

      response.status.should == 409
    end
  end
end
