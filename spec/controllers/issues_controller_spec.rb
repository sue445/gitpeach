require 'spec_helper'

describe IssuesController do
  describe "PUT update" do
    subject{ put :update, params }

    let(:params){
      {
          id:              issue_id,
          kanban_id:       kanban.name,
          to_label_id:     to_label.id,
      }
    }

    let(:issue_id){ 1 }
    let(:kanban)  { FactoryGirl.create(:kanban) }

    let(:from_label){ kanban.labels.backlog.first! }
    let(:to_label)  { kanban.labels.done.first! }

    before do
      expect(controller).to receive(:gitlab_current_issue_label_id){ from_label.id }
      expect(controller).to receive(:gitlab_issue_labels){ %w(bug high) }
      expect(controller).to receive(:update_gitlab_issue)
    end

    it "should be success" do
      subject
      expect(response).to be_success
    end

    it "should update labels" do
      subject
      expect(assigns(:labels)).to eq %w(bug high)
    end

    it "should update state" do
      subject
      expect(assigns(:state)).to  eq "closed"
    end
  end
end
