# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Admin::AbusesController do
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
    let!(:abuse_id) { create(:abuse).id }

    subject { delete :destroy, id: abuse_id }

    describe "existing object" do
      it { should redirect_to admin_abuses_path }
      it {
        expect { subject }.to change { Abuse.count }.by(-1)
      }
    end

    describe "nonexistent object" do
      let(:abuse_id) { "nonexistent" }

      it { should redirect_to admin_abuses_path }
    end
  end
end
