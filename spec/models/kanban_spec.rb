describe Kanban do
  describe "#create_default_labels" do
    subject(:create_default_labels){ kanban.save! }

    let(:kanban){ FactoryGirl.build(:kanban) }

    it{ expect{ subject }.to change(kanban.labels, :count).by(4) }

    describe "1st label" do
      subject do
        create_default_labels
        kanban.labels[0]
      end

      its(:name)            { should == "Backlog" }
      its(:gitlab_label)    { should be nil }
      its(:disp_order)      { should == 0 }
      its(:is_backlog_issue){ should be true }
      its(:is_close_issue)  { should be false }
    end

    describe "2nd label" do
      subject do
        create_default_labels
        kanban.labels[1]
      end

      its(:name)            { should == "Ready" }
      its(:gitlab_label)    { should == "ready" }
      its(:disp_order)      { should == 1 }
      its(:is_backlog_issue){ should be false }
      its(:is_close_issue)  { should be false }
    end

    describe "3rd label" do
      subject do
        create_default_labels
        kanban.labels[2]
      end

      its(:name)            { should == "In Progress" }
      its(:gitlab_label)    { should == "in progress" }
      its(:disp_order)      { should == 2 }
      its(:is_backlog_issue){ should be false }
      its(:is_close_issue)  { should be false }
    end

    describe "4th label" do
      subject do
        create_default_labels
        kanban.labels[3]
      end

      its(:name)            { should == "Done" }
      its(:gitlab_label)    { should be nil }
      its(:disp_order)      { should == 3 }
      its(:is_backlog_issue){ should be false }
      its(:is_close_issue)  { should be true }
    end
  end

  describe "#issues_group_by_label" do
    before do
      @grouped_issue = kanban.issues_group_by_label(issues)
    end

    let(:kanban){ FactoryGirl.create(:kanban) }
    let(:issues){
      [
          # backlog
          Gitlab::ObjectifiedHash.new(id: 1 , state: "opened"  , labels: nil),
          Gitlab::ObjectifiedHash.new(id: 2 , state: "reopened", labels: ["Bug", "Hotfix"]),

          # ready
          Gitlab::ObjectifiedHash.new(id: 3 , state: "opened"  , labels: ["ready"]),

          # in progress
          Gitlab::ObjectifiedHash.new(id: 4 , state: "opened"  , labels: ["in progress"]),
          Gitlab::ObjectifiedHash.new(id: 5 , state: "reopened", labels: ["in progress"]),
          Gitlab::ObjectifiedHash.new(id: 6 , state: "opened"  , labels: ["Bug", "in progress"]),

          # done
          Gitlab::ObjectifiedHash.new(id: 7 , state: "closed"  , labels: nil),
          Gitlab::ObjectifiedHash.new(id: 8 , state: "closed"  , labels: ["ready"]),
          Gitlab::ObjectifiedHash.new(id: 9 , state: "closed"  , labels: ["in progress"]),
          Gitlab::ObjectifiedHash.new(id: 10, state: "closed"  , labels: ["Bug", "Hotfix"]),
      ]
    }
    let(:backlog_id)     { kanban.labels.backlog.first.id }
    let(:ready_id)       { kanban.labels.other.find_by(name: "Ready").id }
    let(:in_progress_id) { kanban.labels.other.find_by(name: "In Progress").id }
    let(:done_id)        { kanban.labels.done.first.id }

    it{ expect(@grouped_issue.count).to eq kanban.labels.count }

    it "should return backlog issues" do
      expect(@grouped_issue[backlog_id]).to have(2).items
    end

    it "should return ready issues" do
      expect(@grouped_issue[ready_id]).to have(1).items
    end

    it "should return in progress issues" do
      expect(@grouped_issue[in_progress_id]).to have(3).items
    end

    it "should return done issues" do
      expect(@grouped_issue[done_id]).to have(4).items
    end
  end
end
