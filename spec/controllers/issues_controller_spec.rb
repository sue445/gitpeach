describe IssuesController, type: :controller do
  let(:kanban)  { FactoryGirl.create(:kanban) }

  describe "POST create" do
    subject{ post :create, params }

    let(:params){
      {
          kanban_id: kanban.name,
          title: "some title",
      }
    }

    before do
      allow(controller).to receive(:create_gitlab_issue){}
    end

    it "should be success" do
      subject
      expect(response).to be_success
    end

    it "should be call create_gitlab_issue with valid params" do
      expect(controller).to receive(:create_gitlab_issue).with(params[:title])
      subject
    end
  end

  describe "GET show" do
    subject{ get :show, params }

    let(:params){
      {
          id:        issue_id,
          kanban_id: kanban.name,
      }
    }

    let(:issue_id){ 1 }

    it "should be success" do
      subject
      expect(response).to be_success
    end
  end

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

    let(:from_label){ kanban.labels.backlog.first! }
    let(:to_label)  { kanban.labels.done.first! }

    before do
      expect(controller).to receive(:gitlab_current_issue_label_id){ from_label.id }
      expect(controller).to receive(:gitlab_issue_labels){ %w(bug high) }
      expect(controller).to receive(:update_gitlab_issue)
      expect(controller).to receive(:updated_issue)      { {} }
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
      expect(assigns(:state)).to  eq "close"
    end
  end
end
