# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Admin::UserSessionsController do
  setup :activate_authlogic

  describe "#new" do
    subject { get :new }

    its(:status) { should == 200 }
  end

  describe "#create" do
    let!(:user) { create(:user) }

    subject { post :create, user_session: { login: user_login, password: user_password } }

    describe "correct login data" do
      let(:user_login) { user.login }
      let(:user_password) { user.password }

      it { expect { subject }.to change { flash[:notice] }.to("Poprawnie zalogowano!") }
      it { should redirect_to(admin_reports_path) }
    end

    describe "wrong login data" do
      let(:user_login) { "blahblah" }
      let(:user_password) { "blabla" }

      it { expect { subject }.to change { flash[:alert] }.to("Niepoprawne dane logowania!") }
      it { should render_template('new') }
    end
  end

  describe "#destroy" do
    subject { delete :destroy }

    describe "redirect to main admin page" do
      it { should redirect_to(root_path) }
    end
  end
end
