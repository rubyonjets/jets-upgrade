module JetsUpgrade::Rewrite
  class Application < Base
    def filename
      "config/application.rb"
    end

    def marker
      " < Jets::Application"
    end

    def content
      inside_do_block = false
      modified_lines = lines.map do |line|
        if line.match(/Jets\.application\.configure\s+do/)
          inside_do_block = true
          "module Main\n  class Application < Jets::Application\n"
        elsif inside_do_block && line.match(/^\s*end\s*$/)
          inside_do_block = false
          "  end\nend\n"
        elsif inside_do_block
          if line.match(/^\s+$/)
            "\n"
          elsif line.match(/config.controllers.filtered_parameters(.*)/)
            "    # Recommend moving filter_parameters to config/initializers/filter_parameter_logging.rb instead\n" \
            "    #    Jets.application.config.filter_parameters#{$1}\n" \
            "    config.filter_parameters#{$1}\n"
          else
            "  #{line}" # add 2 spaces
          end
        else
          line
        end
      end.compact
      modified_lines.join('')
    end
  end
end
