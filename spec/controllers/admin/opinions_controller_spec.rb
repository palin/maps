# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Admin::OpinionsController do
  setup :activate_authlogic

  before do
    activate_authlogic
    @user = FactoryGirl.create(:user)
    UserSession.create(@user, true)
  end

  describe "#index" do
    it "responses with 200" do
      get :index
      response.code.should == "200"
    end
  end

  describe "#destroy" do
    it "responses with 200 after deleting object" do
      opinion = FactoryGirl.create(:opinion)

      delete :destroy, :id => opinion.id

      response.should redirect_to admin_opinions_path
    end

    it "redirects to admin/opinions if opinion doesn't exist" do
      delete :destroy, :id => 'nonexistent'

      response.should redirect_to admin_opinions_path
    end

    it "correctly deletes object from database" do
      opinion = FactoryGirl.create(:opinion)
      now = Opinion.count

      delete :destroy, :id => opinion.id

      Opinion.count.should == now-1
    end
  end
end