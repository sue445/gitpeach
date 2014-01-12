require 'spec_helper'

describe "Kanbans" do
  describe "GET /kanbans" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get kanbans_path
      expect(response.status).to be(200)
    end
  end
end
