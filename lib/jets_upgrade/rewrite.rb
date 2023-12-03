module JetsUpgrade
  module Rewrite
    def run
      Application.run
      Rakefile.run
      Gemfile.run
      rewrite_environment_files
      rewrite_controllers
    end

    def rewrite_environment_files
      %w[development test production].each do |env|
        Environment.new(env).run
      end
    end

    def rewrite_controllers
      Dir.glob("app/controllers/**/*_controller.rb").each do |path|
        next if path.include?("application_controller.rb")
        Controller.new(path).run
      end
    end

    extend self
  end
end

