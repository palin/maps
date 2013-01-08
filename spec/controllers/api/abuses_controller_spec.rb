# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Api::AbusesController do



  describe "#duplicate" do
    it "correctly responses with thanks message" do
      report = FactoryGirl.create(:report)

      post :duplicate, :report_id => report.id

      response.body.should == {:success => true, :thanks => "Informacja o duplikacie została wysłana do moderatorów."}.to_json
    end
  end

  describe "#content" do

    it "correctly responses with thanks message" do
      report = FactoryGirl.create(:report)

      post :content, :report_id => report.id

      response.body.should == {:success => true, :thanks => "Informacja o nieodpowiedniej treści została wysłana do moderatorów."}.to_json
    end
  end

  describe "#solved" do
    it "correctly responses with thanks message" do
      report = FactoryGirl.create(:report)

      post :solved, :report_id => report.id

      response.body.should == {:success => true, :thanks => "Informacja o rozwiązaniu problemu została wysłana do moderatorów."}.to_json
    end
  end

  describe "#spam" do
    it "correctly responses with thanks message" do
      report = FactoryGirl.create(:report)

      post :spam, :report_id => report.id

      response.body.should == {:success => true, :thanks => "Informacja o spamie została wysłana do moderatorów."}.to_json
    end
  end
end