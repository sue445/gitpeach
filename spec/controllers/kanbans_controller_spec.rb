# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe KanbansController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Kanban. As you add validations to Kanban, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "gitlab_project_id" => "1", "name" => "namespace/path" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # KanbansController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET show" do
    before do
      allow(controller).to receive(:project_issues).and_return([])
    end

    it "assigns the requested kanban as @kanban" do
      kanban = Kanban.create! valid_attributes
      get :show, {:id => kanban.to_param}, valid_session
      expect(assigns(:kanban)).to eq(kanban)
    end
  end

  describe "GET edit" do
    it "assigns the requested kanban as @kanban" do
      kanban = Kanban.create! valid_attributes
      get :edit, {:id => kanban.to_param}, valid_session
      expect(assigns(:kanban)).to eq(kanban)
    end
  end

  describe "POST create" do
    it "creates a new Kanban" do
      expect {
        post :create, {:kanban => valid_attributes}, valid_session
      }.to change(Kanban, :count).by(1)
    end

    it "assigns a newly created kanban as @kanban" do
      post :create, {:kanban => valid_attributes}, valid_session
      expect(assigns(:kanban)).to be_a(Kanban)
      expect(assigns(:kanban)).to be_persisted
    end

    it "redirects to the created kanban" do
      post :create, {:kanban => valid_attributes}, valid_session
      expect(response).to redirect_to(Kanban.last)
    end
  end

  describe "PUT update" do
    subject{ put :update, params }

    let(:params) do
      {
          id:     kanban.name,
          labels: labels,
      }
    end

    let(:labels) do
      [
          {name: "Backlog"    , gitlab_label: nil          , is_backlog_issue: true , is_close_issue: false, id: backlog.id},
          {name: "Ready"      , gitlab_label: "ready"      , is_backlog_issue: false, is_close_issue: false, id: ready.id},
          {name: "In Progress", gitlab_label: "in progress", is_backlog_issue: false, is_close_issue: false, id: in_progress.id},
          {name: "Done"       , gitlab_label: nil          , is_backlog_issue: false, is_close_issue: true , id: done.id},
      ]
    end

    let!(:kanban)    { FactoryGirl.create(:kanban) }
    let(:backlog)    { kanban.labels.backlog.first }
    let(:ready)      { kanban.labels.other.where(name: "Ready").first }
    let(:in_progress){ kanban.labels.other.where(name: "In Progress").first }
    let(:done)       { kanban.labels.done.first }

    it "should be redirect" do
      subject
      expect(response).to be_redirect
    end

    context "When update label" do
      before do
        labels[0][:name]         = "TODO"
        labels[1][:gitlab_label] = "ready5"
      end

      it{ expect{ subject }.to change{ Label.find(backlog.id).name       }.from("Backlog").to("TODO") }
      it{ expect{ subject }.to change{ Label.find(ready.id).gitlab_label }.from("ready").to("ready5") }
    end

    context "When add new label" do
      before do
        labels.insert(1, new_label)
      end

      let(:new_label) do
        {name: "Pending", gitlab_label: "pending", is_backlog_issue: false, is_close_issue: false}
      end

      it{ expect{ subject }.to change(Label, :count).by(1) }
      it{ expect{ subject }.to change{ Label.find(done.id).disp_order }.from(3).to(4) }
    end

    context "When delete label" do
      before do
        labels.delete_at(2)
      end

      it{ expect{ subject }.to change(Label, :count).by(-1) }
      it{ expect{ subject }.to change{ Label.where(id: in_progress.id).exists? }.from(true).to(false) }
    end

    context "When swap labels" do
      before do
        labels[0], labels[1] = labels[1], labels[0]
      end

      it{ expect{ subject }.to change{ Label.find(backlog.id).disp_order }.from(0).to(1) }
      it{ expect{ subject }.to change{ Label.find(ready.id).disp_order   }.from(1).to(0) }
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested kanban" do
      kanban = Kanban.create! valid_attributes
      expect {
        delete :destroy, {:id => kanban.to_param}, valid_session
      }.to change(Kanban, :count).by(-1)
    end

    it "redirects to the top" do
      kanban = Kanban.create! valid_attributes
      delete :destroy, {:id => kanban.to_param}, valid_session
      expect(response).to redirect_to(root_url)
    end
  end

end
