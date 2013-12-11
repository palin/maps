# -*- encoding : utf-8 -*-
require 'spec_helper'

describe V1::MapsController do
  context "#border" do
    subject { get :border, format: :json }

    its(:status) { should == 200 }
  end
end
