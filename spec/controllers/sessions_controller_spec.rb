describe SessionsController do
  describe "GET 'create'" do
    include_context :using_gitlab_mock

    subject{ post 'create', valid_params }

    before do
      json = <<JSON
{"id":1,"username":"momozono_love","email":"cure_peach@fresh.precure","name":"Momozono Love","bio":null,"skype":"","linkedin":"","twitter":"","theme_id":2,"color_scheme_id":1,"state":"active","created_at":"2014-01-05T17:10:37.000Z","extern_uid":null,"provider":null,"is_admin":false,"can_create_group":false,"can_create_project":false,"private_token":"gitlab_private_token"}
JSON
      stub_request(:post, "#{gitlab_endpoint}/session?private_token=#{gitlab_private_token}").
          with(:body => "email=#{login}&password=#{password}",
               :headers => {'Accept'=>'application/json'}).
          to_return(:status => 200, :body => json, :headers => {})
    end

    let(:login)   { "momozono_love" }
    let(:password){ "cure_peach" }
    let(:valid_params)  {
      {
          login:    login,
          password: password,
      }
    }

    describe "action behavior" do
      before do
        subject
      end

      it "returns http redirect" do
        expect(response).to be_redirect
      end

      it{ expect(response).to redirect_to root_path }

      it{ expect(session[:user_id]).not_to be_nil }
    end

    context "When not exists user" do
      before do
        subject
      end

      it{ expect(User.count).to eq 1 }

      let(:user){ User.first }
      it_behaves_like :a_user
    end

    context "When exists user" do
      before do
        @user = FactoryGirl.create(:momozono_love)
        subject
      end

      it{ expect(User.count).to eq 1 }

      let(:user){ @user }
      it_behaves_like :a_user
    end
  end

  describe "GET 'destroy'" do
    subject{ get 'destroy' }

    before do
      subject
    end

    it "returns http success" do
      expect(response).to be_redirect
    end

    it{ expect(response).to redirect_to root_path }

    it{ expect(session[:user_id]).to be_nil }
  end

end
