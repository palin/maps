# -*- encoding : utf-8 -*-
require 'spec_helper'

describe HomeController do
  describe "#index" do
    subject { get :index }

    its(:code) { should == "200" }
  end
end