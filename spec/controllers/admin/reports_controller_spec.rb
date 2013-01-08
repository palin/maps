# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Admin::ReportsController do
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

  describe "#edit" do
    it "responses with 200 if report exists" do
      c = FactoryGirl.create(:report)

      get :edit, :id => c.id

      response.code.should == "200"
    end

    it "redirects to admin/reports if report doesn't exist" do
      get :edit, :id => 'nonexistent'

      response.should redirect_to(admin_reports_path)
    end
  end

  describe "#update" do
    it "redirects to admin/reports if updated failed" do
      put :update, :id => 'nonexistent'

      response.should redirect_to(admin_reports_path)
    end

    it "correctly updates object" do
      c = FactoryGirl.create(:report)

      put :update, {:id => c.id, :report => {:title => 'new_title'}}

      c.reload.title.should == 'new_title'
    end

    it "redirects to admin/reports if updated successfully" do
      c = FactoryGirl.create(:report)

      put :update, {:id => c.id, :report => {:title => 'new_title'}}

      flash[:notice].should == "Zgłoszenie zostało zaktualizowane!"
      response.should redirect_to(admin_reports_path)
    end

    it "renders edit layout if problem with save" do
      c = FactoryGirl.create(:report)

      put :update, {:id => c.id, :report => {:title => nil}}

      flash[:alert].should == "Wystąpił problem. Sprawdź dane formularza."
      response.should render_template("edit")
    end
  end

  describe "#destroy" do
    it "redirect to admin/reports if report doesn't exits" do
      delete :destroy, :id => 'nonexistent'

      response.should redirect_to(admin_reports_path)
    end

    it "destroy report correctly" do
      c = FactoryGirl.create(:report)
      now = Report.count

      delete :destroy, :id => c

      Report.count.should == now - 1
    end

    it "redirects to admin/reports with flash notice after successful destroy" do
      c = FactoryGirl.create(:report)

      delete :destroy, :id => c

      flash[:notice].should == "Zgłoszenie zostało usunięte!"
      response.should redirect_to(admin_reports_path)
    end
  end
end