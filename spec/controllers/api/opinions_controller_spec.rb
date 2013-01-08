# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Api::OpinionsController do

  describe "#add" do
    it "correctly adds new opinion" do
      r = FactoryGirl.create(:report)

      now = Opinion.count

      post :add, {:title => "tytul opinii", :description => "opis opinii dlugiej", :report_id => r.id}

      Opinion.count.should == now + 1
    end
  end

end