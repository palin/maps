# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Admin::UserSessionsController do
  setup :activate_authlogic

  describe "#new" do
    it "responses with 200" do
      get :new
      response.code.should == "200"
    end
  end

  describe "#create" do
    it "creates correctly user session and redirects to admin panel" do
      user = FactoryGirl.create(:user)

      post :create, :user_session => {:login => user.login, :password => user.password}
      flash[:notice].should == "Poprawnie zalogowano!"
      response.should redirect_to(admin_reports_path)
    end

    it "creates correctly user session and redirects to admin panel" do
      post :create, :user_session => {:login => 'bleble', :password => 'bleble'}

      flash[:alert].should == "Niepoprawne dane logowania!"
      response.should render_template('new')
    end
  end

  describe "#destroy" do
    it "doesn't return error if session wasn't created" do
      delete :destroy

      response.should redirect_to(root_path)
    end

    it "redirects to root path after unlogging" do
      FactoryGirl.create(:user)

      delete :destroy

      response.should redirect_to(root_path)
    end
  end
end