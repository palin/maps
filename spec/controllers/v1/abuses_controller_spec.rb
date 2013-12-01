# -*- encoding : utf-8 -*-
require 'spec_helper'

describe V1::AbusesController do

  let!(:report) { create(:report) }

  context "#duplicate" do
    subject { post :duplicate, report_id: report.id }

    its(:status) { should == 200 }
    its(:body) { should == { success: true, thanks: "Informacja o duplikacie została wysłana do moderatorów." }.to_json }
  end

  context "#content" do
    subject { post :content, report_id: report.id }

    its(:status) { should == 200 }
    its(:body) { should == { success: true, thanks: "Informacja o nieodpowiedniej treści została wysłana do moderatorów." }.to_json }
  end

  context "#solved" do
    subject { post :solved, report_id: report.id }

    its(:status) { should == 200 }
    its(:body) { should == { success: true, thanks: "Informacja o rozwiązaniu problemu została wysłana do moderatorów." }.to_json }
  end

  context "#spam" do
    subject { post :spam, report_id: report.id }

    its(:status) { should == 200 }
    its(:body) { should == { success: true, thanks: "Informacja o spamie została wysłana do moderatorów." }.to_json }
  end
end
