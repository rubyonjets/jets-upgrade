require "fileutils"

module JetsUpgrade
  class PublicIndex
    def run
      return unless File.exist?(filename)

      lines = IO.readlines(filename)
      if lines.detect { |l| l.include?("Welcome and congrats") }
        FileUtils.rm(filename)
        puts "Removed #{filename}. Jets handles with jets/welcome#index controller"
      end
    end

    def filename
      "public/index.html"
    end

    def self.run
      new.run
    end
  end
end
