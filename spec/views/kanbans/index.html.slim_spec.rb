require 'spec_helper'

describe "kanbans/index" do
  before(:each) do
    assign(:kanbans, [
      stub_model(Kanban,
        :gitlab_project_id => 1,
        :name => "Name",
        :slug => "Slug"
      ),
      stub_model(Kanban,
        :gitlab_project_id => 1,
        :name => "Name",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of kanbans" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
