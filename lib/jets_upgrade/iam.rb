module JetsUpgrade
  class Iam
    def run
      # warn_about_iam_policies
      Dir.glob("app/controllers/**/*").each do |path|
        next if File.directory?(path)
        next if path =~ /application_controller\.rb$/
        warn(path)
      end
    end

    def warn(path)
      lines = IO.readlines(path)
      lines.each_with_index do |line, i|
        n = i + 1
        if line =~ /iam_policy/
          puts "WARNING: #{path}:#{n} contains iam_policy".color(:yellow)
          puts <<~EOL
            Please move the iam_policy the ApplicationController
            or config/application.rb

            Jets v5 deploys a single Lambda function for controllers so
            the iam_policy at each controller does not work anymore.
          EOL
        end
      end
    end

    def self.run
      new.run
    end
  end
end
