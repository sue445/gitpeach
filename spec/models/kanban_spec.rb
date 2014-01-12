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
end
