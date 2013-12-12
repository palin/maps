# -*- encoding : utf-8 -*-
require 'spec_helper'

describe MapBorder do
  context "#prepare_coords" do
    subject { described_class.prepare_coords }

    its(:size) { should == 65 }
    its('first.size') { should == 2 }
  end
end
