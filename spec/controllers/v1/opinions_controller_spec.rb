# -*- encoding : utf-8 -*-
require 'spec_helper'

describe V1::OpinionsController do
  render_views

  let!(:report) { create(:report) }

  context "#create" do
    subject { post :create, format: :json, report_id: report.id, opinion: opinion }

    describe "correct parameters" do
      let(:title) { "tytul opinii" }
      let(:description) { "opis opinii dlugiej" }
      let(:opinion) { { title: title, description: description } }

      its(:status) { should == 200 }
      it { expect { subject }.to change { Opinion.count }.by(1) }

      context "response data" do
        let(:data) { MultiJson.load(subject.body) }

        it { data.length.should == 8 }
        it { data['title'].should == title }
        it { data['description'].should == description }
        it { data['report_id'].should == report.id }
      end
    end

    describe "incorrect parameters" do
      let(:opinion) { { title: "a" } }

      its(:status) { should == 422 }
      it { expect { subject }.not_to change { Opinion.count }.by(1) }
    end
  end

  context "#index" do
    subject { get :index, format: :json, report_id: report.id }

    let!(:opinion_1) { create :opinion, report: report }
    let!(:opinion_2) { create :opinion, report: report }

    its(:status) { should == 200 }

    context "response data" do
      let(:data) { MultiJson.load(subject.body)['opinions'] }

      it { data.length.should == 2 }
      it { data[0]['report_id'].should == report.id }
      it { data[1]['report_id'].should == report.id }
    end
  end

  context "#update" do
    subject { put :update, format: :json, report_id: report.id, id: opinion.id, opinion: { key: key } }

    let(:key) { nil }
    let!(:opinion) { create :opinion, report: report }

    describe "turned on cookies" do
      before { request.cookies["_reporter_session"] = "aaa" }

      its(:status) { should == 200 }

      describe "with existing cookie" do
        before { request.cookies["opinion_id_#{opinion.id}"] = "1" }

        context "rating up" do
          let(:key) { "positives" }

          its(:status) { should == 403 }
          it { expect { subject }.not_to change { opinion.reload.positives }.to(1) }
        end

        context "rating down" do
          let(:key) { "negatives" }

          its(:status) { should == 403 }
          it { expect { subject }.not_to change { opinion.reload.negatives }.to(1) }
        end
      end

      describe "without cookie" do
        context "rating up" do
          let(:key) { "positives" }

          its(:status) { should == 200 }
          it { expect { subject }.to change { opinion.reload.positives }.to(1) }
        end

        context "rating down" do
          let(:key) { "negatives" }

          its(:status) { should == 200 }
          it { expect { subject }.to change { opinion.reload.negatives }.to(1) }
        end
      end

      context "response data" do
        let(:data) { MultiJson.load(subject.body) }

        it { data.length.should == 6 }
        it { data['title'].should == opinion.title }
        it { data['description'].should == opinion.description }
        it { data['report_id'].should == report.id }
      end
    end

    describe "turned off cookies" do
      before { request.cookies["_reporter_session"] = nil }

      its(:status) { should == 403 }
    end
  end

  context "#show" do
    subject { get :show, format: :json, report_id: report.id, id: opinion.id }

    let!(:opinion) { create :opinion, report: report }

    its(:status) { should == 200 }

    context "response data" do
      let(:data) { MultiJson.load(subject.body) }

      it { data.length.should == 8 }
      it { data['title'].should == opinion.title }
      it { data['description'].should == opinion.description }
      it { data['report_id'].should == report.id }
    end
  end
end
