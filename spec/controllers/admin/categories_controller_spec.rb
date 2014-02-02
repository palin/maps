# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Admin::CategoriesController do
  setup :activate_authlogic

  before do
    activate_authlogic
    @user = create(:user)
    UserSession.create(@user, true)
  end

  let!(:category) { create(:category) }
  let(:category_id) { category.id }

  describe "#index" do
    subject { get :index }

    its(:status) { should == 200 }
  end

  describe "#edit" do

    subject { get :edit, id: category_id }

    describe "existing category" do
      its(:status) { should == 200 }
    end
  end

  describe "#update" do
    let(:new_unique_id) { 'abc' }

    subject { put :update, { id: category_id, category: { unique_id: new_unique_id } } }

    describe "existing object" do
      it { should redirect_to(admin_categories_path) }
      it { expect { subject }.to change { category.reload.unique_id }.to "abc" }
      it { expect { subject }.to change { flash[:notice] }.to("Kategoria została zaktualizowana!") }
    end

    describe "nonexistent object" do
      let(:category_id) { "nonexistent" }

      it { should redirect_to(admin_categories_path) }
    end

    describe "issues with save" do
      let(:new_unique_id) { nil }

      it { expect { subject }.to change { flash[:alert] }.to("Wystąpił problem. Sprawdź dane formularza.") }
      it { should render_template("edit") }
    end
  end

  describe "#destroy" do
    let(:category_id) { category.id }

    subject { delete :destroy, id: category_id }

    describe "existing object" do
      it { expect { delete :destroy, id: category_id }.to change(Category, :count).by(-1) }
      it { expect { subject }.to change { flash[:notice] }.to("Kategoria została usunięta!") }
      it { should redirect_to(admin_categories_path) }
    end

    describe "nonexistent object" do
      let(:category_id) { "nonexistent" }

      it { should redirect_to(admin_categories_path) }
    end
  end
end
