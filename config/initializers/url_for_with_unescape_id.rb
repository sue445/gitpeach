# via.
# * https://github.com/rails/rails/blob/v4.1.2/actionpack/CHANGELOG.md
# * https://github.com/rails/rails/commit/8a067640e6fe222022dc77bb63d5da37ef75a189

def url_for_with_unescape_id(options = nil)
  path = url_for_without_unescape_id(options)

  if options.is_a?(Hash)
    original_id = options[:id].try(:to_s)
    unless path.include?(original_id)
      # id is escaped
      escaped_id = URI.encode_www_form_component(original_id)
      path = path.gsub(escaped_id, original_id)
    end
  end

  path
end

module ActionView
  module RoutingUrlFor
    alias_method_chain :url_for, :unescape_id
  end
end

class ActionController::Base
  alias_method_chain :url_for, :unescape_id
end
