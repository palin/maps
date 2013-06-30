# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Api::AbusesController do

  let!(:report) { FactoryGirl.create(:report) }

  describe "#duplicate" do
    subject { post :duplicate, :report_id => report.id }

    its(:code) { should == "200" }
    its(:body) { should == {:success => true, :thanks => "Informacja o duplikacie została wysłana do moderatorów."}.to_json }
  end

  describe "#content" do
    subject { post :content, :report_id => report.id }

    its(:code) { should == "200" }
    its(:body) { should == {:success => true, :thanks => "Informacja o nieodpowiedniej treści została wysłana do moderatorów."}.to_json }
  end

  describe "#solved" do
    subject { post :solved, :report_id => report.id }

    its(:code) { should == "200" }
    its(:body) { should == {:success => true, :thanks => "Informacja o rozwiązaniu problemu została wysłana do moderatorów."}.to_json }
  end

  describe "#spam" do
    subject { post :spam, :report_id => report.id }

    its(:code) { should == "200" }
    its(:body) { should == {:success => true, :thanks => "Informacja o spamie została wysłana do moderatorów."}.to_json }
  end
end