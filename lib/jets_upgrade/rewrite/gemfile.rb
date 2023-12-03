module JetsUpgrade::Rewrite
  class Gemfile < Base
    def filename
      "Gemfile"
    end

    def marker
      "sprockets-jets"
    end

    def content
      new_gems = <<~EOL
        gem "jets", "~> 5.0.0"
        gem "importmap-jets"
        gem "sprockets-jets"
        gem "sassc" # only required if using sass in stylesheets
      EOL
      new_dynomite = <<~EOL
        gem "dynomite", "~> 2.0.0" # recommend upgrading
      EOL

      modified_lines = lines.map do |line|
        if line =~ /gem "jets"/
          line = "# #{line}" + new_gems
        end
        if line =~ /gem "jetpacker"/ && @options[:javascript]
          line = "# #{line}"
        end
        if line =~ /gem "dynomite"/
          if using_dynomite?
            line = "# #{line}" + new_dynomite
          else
            line = "# #{line}"
          end
        end
        line
      end

      modified_lines.join('')
    end

    def message
      puts <<~EOL
        Your Gemfile has been updated. Please run:

      EOL
      puts "    bundle install".color(:green)
      puts
    end

    def using_dynomite?
      File.exist?("app/models/application_item.rb")
    end
  end
end
