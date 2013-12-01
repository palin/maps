# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Admin::OpinionsController do
  setup :activate_authlogic

  before do
    activate_authlogic
    @user = create(:user)
    UserSession.create(@user, true)
  end

  describe "#index" do
    subject { get :index }

    its(:status) { should == 200 }
  end

  describe "#destroy" do
    let!(:opinion_id) { create(:opinion).id }

    subject { delete :destroy, id: opinion_id }

    describe "existing object" do
      it { should redirect_to admin_opinions_path }
      it { expect { subject }.to change(Opinion, :count).by(-1) }
    end

    describe "nonexistent object" do
      let(:opinion_id) { "nonexistent" }

      it { should redirect_to admin_opinions_path }
    end
  end
end
