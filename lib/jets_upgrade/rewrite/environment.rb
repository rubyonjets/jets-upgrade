module JetsUpgrade::Rewrite
  class Environment < Base
    def initialize(name)
      @name = name
    end

    def filename
      "config/environments/#{@name}.rb"
    end

    def marker
      "config.eager_load"
    end

    def for_env(env)
      send("for_#{env}")
    end

    def for_test
      <<EOL
  config.cache_classes = false
  config.eager_load = ENV["CI"].present?
  config.cache_store = :null_store
  config.consider_all_requests_local = true
  config.server_timing = true
  config.jets_controller.perform_caching = false
  config.action_dispatch.show_exceptions = false
  config.action_mailer.delivery_method = :test
  config.action_mailer.perform_caching = false
  # config.action_mailer.default_url_options = { host: 'localhost', port: 8888 }
EOL
    end

    def for_production
      <<EOL
  config.cache_classes = true
  config.eager_load = true
  config.log_level = :info
  config.logging.event = false # true can be useful for CloudWatch logs but pretty noisy locally
  config.consider_all_requests_local       = false
  config.assets.compile = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  # config.action_mailer.default_url_options = { host: 'localhost', port: 8888 }
EOL
    end

    def for_development
      <<EOL
  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true

  config.action_dispatch.show_exceptions = true

  # Enable/disable caching. By default caching is disabled.
  if Jets.root.join("tmp/caching-dev.txt").exist?
    config.jets_controller.perform_caching = true
    config.cache_store = :memory_store
  else
    config.jets_controller.perform_caching = false
    config.cache_store = :null_store
  end

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  # config.action_mailer.default_url_options = { host: 'localhost', port: 8888 }

  config.logging.event = false # true can be useful for CloudWatch logs but pretty noisy locally
EOL
    end

    def content
      new_configs = for_env(@name)

      inside_do_block = false
      modified_lines = lines.map do |line|
        if line.match(/Jets\.application\.configure\s+do/)
          inside_do_block = true
          line + new_configs
        elsif inside_do_block && line.match(/^\s*end\s*$/)
          inside_do_block = false
          line
        elsif inside_do_block
          if line.match(/^\s+$/)
            "\n"
          else
            line
          end
        else
          line
        end
      end.compact
      modified_lines.join('')
    end
  end
end
