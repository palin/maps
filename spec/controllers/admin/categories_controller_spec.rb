# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Admin::CategoriesController do
  setup :activate_authlogic

  before do
    activate_authlogic
    @user = FactoryGirl.create(:user)
    UserSession.create(@user, true)
  end

  let!(:category) { FactoryGirl.create(:category) }
  let(:category_id) { category.id }

  describe "#index" do
    subject { get :index }

    its(:code) { should == "200" }
  end

  describe "#edit" do

    subject { get :edit, id: category_id }

    describe "existing category" do
      its(:code) { should == "200" }
    end

    describe "nonexistent category" do
      let(:category_id) { "nonexistent" }

      it { should redirect_to(admin_categories_path) }
    end
  end

  describe "#update" do
    let(:new_title) { 'new_title' }

    subject { put :update, { id: category_id, category: { title: new_title } } }

    describe "existing object" do
      it { should redirect_to(admin_categories_path) }
      it {
        expect { subject }.to change { category.reload.title }.to "new_title"
      }
      it {
        subject
        flash[:notice].should == "Kategoria została zaktualizowana!"
      }
    end

    describe "nonexistent object" do
      let(:category_id) { "nonexistent" }

      it { should redirect_to(admin_categories_path) }
    end

    describe "issues with save" do
      let(:new_title) { nil }

      it {
        subject
        flash[:alert].should == "Wystąpił problem. Sprawdź dane formularza."
      }
      it { should render_template("edit") }
    end
  end

  describe "#destroy" do
    let(:category_id) { category.id }

    subject { delete :destroy, id: category_id }

    describe "existing object" do
      it { should redirect_to(admin_categories_path) }
      it {
        expect { delete :destroy, id: category_id }.to change(Category, :count).by(-1)
      }
      it {
        subject
        flash[:notice].should == "Kategoria została usunięta!"
      }
      it { should redirect_to(admin_categories_path) }
    end

    describe "nonexistent object" do
      let(:category_id) { "nonexistent" }

      it { should redirect_to(admin_categories_path) }
    end
  end
end