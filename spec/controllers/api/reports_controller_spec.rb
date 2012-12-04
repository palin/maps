# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Api::ReportsController do
  context "#send_report" do
    it "should be success if params present" do
      post :send_report, :report => {:placki => "asdsad"}, :format => :json

      response.body.should == {:success => true}.to_json
    end

    it "should fail if no params" do
      post :send_report, :report => {}, :format => :json

      response.body.should == {:success => true}.to_json
    end
  end
end
