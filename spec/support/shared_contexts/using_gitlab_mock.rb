shared_context :using_gitlab_mock do
  before do
    Gitlab.configure do |config|
      config.endpoint       = gitlab_endpoint
      config.private_token  = gitlab_private_token
    end
  end

  let(:gitlab_endpoint)     { "https://example.net/api/v3" }
  let(:gitlab_private_token){ "gitlab_private_token" }
end
