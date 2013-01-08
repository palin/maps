# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Api::MapsController do
  describe "#border" do
    it "returns 200 OK" do
      post :border

      response.code.should == "200"
    end
  end
end