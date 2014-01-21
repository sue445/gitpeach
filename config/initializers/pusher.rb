require 'pusher'

pusher_config = YAML.load_file(File.join(Rails.root, "config", "pusher.yml")).with_indifferent_access

Pusher.app_id = pusher_config[Rails.env][:app_id]
Pusher.key    = pusher_config[Rails.env][:key]
Pusher.secret = pusher_config[Rails.env][:secret]

Pusher.logger = Rails.logger
