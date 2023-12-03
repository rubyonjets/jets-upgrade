class JetsUpgrade::Javascript
  class Gitignore < Base
    def run
      return unless File.exist?(".gitignore")
      lines = IO.readlines(".gitignore")
      return if lines.detect { |l| l.include?("public/assets") }
      lines << "public/assets\n"
      content = lines.join('')
      IO.write(".gitignore", content)
    end

    def self.run
      new.run
    end
  end
end
