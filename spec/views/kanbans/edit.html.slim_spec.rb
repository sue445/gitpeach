require 'spec_helper'

describe "kanbans/edit" do
  before(:each) do
    @kanban = assign(:kanban, stub_model(Kanban,
      :gitlab_project_id => 1,
      :name => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders the edit kanban form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", kanban_path(@kanban), "post" do
      assert_select "input#kanban_gitlab_project_id[name=?]", "kanban[gitlab_project_id]"
      assert_select "input#kanban_name[name=?]", "kanban[name]"
      assert_select "input#kanban_slug[name=?]", "kanban[slug]"
    end
  end
end
