# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Admin::CategoriesController do
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
    it "responses with 200 if category exists" do
      c = FactoryGirl.create(:category)

      get :edit, :id => c.id

      response.code.should == "200"
    end

    it "redirects to admin/categories if category doesn't exist" do
      get :edit, :id => 'nonexistent'

      response.should redirect_to(admin_categories_path)
    end
  end

  describe "#update" do
    it "redirects to admin/categories if updated failed" do
      put :update, :id => 'nonexistent'

      response.should redirect_to(admin_categories_path)
    end

    it "correctly updates object" do
      c = FactoryGirl.create(:category)

      put :update, {:id => c.id, :category => {:title => 'new_title'}}

      c.reload.title.should == 'new_title'
    end

    it "redirects to admin/categories if updated successfully" do
      c = FactoryGirl.create(:category)

      put :update, {:id => c.id, :category => {:title => 'new_title'}}

      flash[:notice].should == "Kategoria została zaktualizowana!"
      response.should redirect_to(admin_categories_path)
    end

    it "renders edit layout if problem with save" do
      c = FactoryGirl.create(:category)

      put :update, {:id => c.id, :category => {:title => nil}}

      flash[:alert].should == "Wystąpił problem. Sprawdź dane formularza."
      response.should render_template("edit")
    end
  end

  describe "#destroy" do
    it "redirect to admin/categories if category doesn't exits" do
      delete :destroy, :id => 'nonexistent'

      response.should redirect_to(admin_categories_path)
    end

    it "destroy category correctly" do
      c = FactoryGirl.create(:category)
      now = Category.count

      delete :destroy, :id => c

      Category.count.should == now - 1
    end

    it "redirects to admin/categories with flash notice after successful destroy" do
      c = FactoryGirl.create(:category)

      delete :destroy, :id => c

      flash[:notice].should == "Kategoria została usunięta!"
      response.should redirect_to(admin_categories_path)
    end
  end
end