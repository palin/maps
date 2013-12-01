# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Admin::ReportsController do
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

  describe "#edit" do
    subject { get :edit, id: report_id }

    context "existing report" do
      let(:report_id) { create(:report).id }

      its(:status) { should == 200 }
    end

    context "nonexistent report" do
      let(:report_id) { 'nonexistent' }

      it { should redirect_to(admin_reports_path) }
    end
  end

  describe "#update" do
    subject { put :update, id: report_id, report: report_data }

    let(:report_data) { {} }
    let!(:report) { create(:report) }
    let(:report_id) { report.id }

    context "existing report" do
      describe "correct new data" do
        let(:report_data) { { title: 'new_title' } }

        it { expect { subject }.to change { report.reload.title }.to('new_title') }
        it { expect { subject }.to change { flash[:notice] }.to("Zgłoszenie zostało zaktualizowane!") }
        it { should redirect_to(admin_reports_path) }
      end

      describe "incorrect new data" do
        let(:report_data) { { title: nil } }

        it { expect { subject }.to change { flash[:alert] }.to("Wystąpił problem. Sprawdź dane formularza.") }
        it { should render_template("edit") }
      end
    end

    context "nonexistent report" do
      let(:report_id) { 'nonexistent' }

      it { should redirect_to(admin_reports_path) }
    end
  end

  describe "#destroy" do
    subject { delete :destroy, id: report_id }

    context "existing report" do
      let!(:report_id) { create(:report).id }

      it { expect { subject }.to change { Report.count }.by(-1) }
      it { expect { subject }.to change { flash[:notice] }.to("Zgłoszenie zostało usunięte!") }
      it { should redirect_to(admin_reports_path) }
    end

    context "nonexistent report" do
      let(:report_id) { 'nonexistent' }

      it { should redirect_to(admin_reports_path) }
    end
  end
end
