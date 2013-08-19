# -*- encoding : utf-8 -*-
require 'spec_helper'

describe V1::OpinionsController do

  describe "#add" do
    let!(:report) { FactoryGirl.create(:report) }
    subject { post :add, {:title => "tytul opinii", :description => "opis opinii dlugiej", :report_id => report.id} }

    it {
      expect { subject }.to change(Opinion, :count).by(1)
    }
  end

end