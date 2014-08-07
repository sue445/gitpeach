# unescape url encoded id for rails 4.1.2+
#
# via.
# * https://github.com/rails/rails/blob/v4.1.2/actionpack/CHANGELOG.md
# * https://github.com/rails/rails/commit/8a067640e6fe222022dc77bb63d5da37ef75a189

def url_for_with_unescape_id(options = nil)
  path = url_for_without_unescape_id(options)

  # unescape: %2F -> /
  path.gsub(%r{([a-zA-Z.0-9_\-]+)%2F([a-zA-Z.0-9_\-]+)}){ $1 + "/" + $2 }
end

module ActionView
  module RoutingUrlFor
    alias_method_chain :url_for, :unescape_id
  end
end

class ActionController::Base
  alias_method_chain :url_for, :unescape_id
end
