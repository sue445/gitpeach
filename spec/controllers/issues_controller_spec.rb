require 'spec_helper'

describe IssuesController do
  describe "PUT update" do
    subject{ put :update, params }

    let(:params){
      {
          id:              issue_id,
          kanban_id:       kanban.name,
          from_label_id:   from_label.id,
          to_label_id:     to_label.id,
      }
    }

    let(:issue_id){ 1 }
    let(:kanban)  { FactoryGirl.create(:kanban) }

    let(:from_label){ kanban.labels.other.find_by(gitlab_label: "ready") }
    let(:to_label)  { kanban.labels.other.find_by(gitlab_label: "in progress") }

    it "should update gitlab issue" do
      pending "do after"
      subject
      # TODO
    end
  end
end
