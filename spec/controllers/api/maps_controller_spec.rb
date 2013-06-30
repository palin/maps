# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Api::MapsController do
  describe "#border" do
    subject { get :border }

    its(:code) { should == "200" }
  end
end