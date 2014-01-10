Gitlab.configure do |config|
  gitlab_config = YAML.load_file(File.join(Rails.root, "config", "gitlab.yml")).with_indifferent_access
  config.endpoint       = gitlab_config[Rails.env][:endpoint] # API endpoint URL (required)
  config.private_token  = "dummy"
  #config.user_agent     = 'Custom User Agent'          # user agent, default to 'Gitlab Ruby Gem [version]' (optional)
end
