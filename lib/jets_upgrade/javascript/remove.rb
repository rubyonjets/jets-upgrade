class JetsUpgrade::Javascript
  class Remove < Base
    def run
      return unless any_remove_files_exist?
      puts "Jets v5 defaults to importmap. Do not need node-related code anymore."
      remove_files.each do |path|
        remove(path)
      end
      remove_empty_dir("bin")
    end

    def remove(path)
      if File.exist?(path)
        FileUtils.rm_rf(path)
        puts "Removed #{path}"
      end
    end

    def any_remove_files_exist?
      remove_files.any? { |path| File.exist?(path) }
    end

    def remove_files
      %w[
        node_modules
        babel.config.js
        bin/webpack
        bin/webpack-dev-server
        package.json
        postcss.config.js
        yarn.lock
      ]
    end

    def self.run
      new.run
    end
  end
end
