describe ApplicationHelper, type: :helper do

  # via.
  # * https://github.com/rails/rails/blob/v4.1.2/actionpack/CHANGELOG.md
  # * https://github.com/rails/rails/commit/8a067640e6fe222022dc77bb63d5da37ef75a189
  describe "Upgrade to Rails 4.1.4" do
    let(:slug){ "namespace/repository" }

    describe "url helper" do
      it "should not be escaped" do
        expect(kanban_path(slug)).to eq "/#{slug}"
      end
    end

    describe "#url_for" do
      it "should not be escaped" do
        expect(url_for(controller: :kanbans, action: :edit, id: slug)).to eq "/#{slug}/edit"
      end
    end
  end
end
