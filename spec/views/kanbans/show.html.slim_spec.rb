require 'spec_helper'

describe "kanbans/show" do
  before(:each) do
    @kanban = assign(:kanban, stub_model(Kanban,
      :gitlab_project_id => 1,
      :name => "Name",
      :slug => "Slug"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Slug/)
  end
end
