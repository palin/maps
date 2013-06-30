# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Admin::UserSessionsController do
  setup :activate_authlogic

  describe "#new" do
    subject { get :new }

    its(:code) { should == "200"}
  end

  describe "#create" do
    let!(:user) { FactoryGirl.create(:user) }
    let(:user_login) { user.login }
    let(:user_password) { user.password }

    subject { post :create, :user_session => {:login => user_login, :password => user_password} }

    describe "correct login data" do
      it {
        subject
        flash[:notice].should == "Poprawnie zalogowano!"
      }
      it { should redirect_to(admin_reports_path) }
    end

    describe "wrong login data" do
      let(:user_login) { "blahblah" }
      let(:user_password) { "blabla" }

      it { should render_template('new')}
      it {
        subject
        flash[:alert].should == "Niepoprawne dane logowania!"
      }
    end
  end

  describe "#destroy" do

    subject { delete :destroy }

    describe "redirect to main admin page" do
      it { should redirect_to(root_path) }
    end
  end
end