# -*- encoding : utf-8 -*-
require 'spec_helper'

describe HomeController do
  describe "#index" do
    it "responses with 200 OK" do
      response.code.should == "200"
    end
  end
end