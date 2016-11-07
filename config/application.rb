require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fastlimo
  class Application < Rails::Application

    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      "<div class=\"field_with_errors control-group has-error\">#{html_tag}</div>".html_safe
    }

    config.active_record.raise_in_transactional_callbacks = true
  end
end
