# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Admin::AbusesController do
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
      abuse = FactoryGirl.create(:abuse)

      delete :destroy, :id => abuse.id

      response.should redirect_to admin_abuses_path
    end

    it "redirects to admin/abuses if abuse doesn't exist" do
      delete :destroy, :id => 'nonexistent'

      response.should redirect_to admin_abuses_path
    end

    it "correctly deletes object from database" do
      abuse = FactoryGirl.create(:abuse)
      now = Abuse.count

      delete :destroy, :id => abuse.id

      Abuse.count.should == now-1
    end
  end
end