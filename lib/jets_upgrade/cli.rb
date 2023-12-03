module JetsUpgrade
  class CLI < Command
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean

    desc "go", "Run jets upgrade script"
    long_desc Help.text(:go)
    def go
      Go.new(options).run
    end

    desc "version", "prints version"
    def version
      puts VERSION
    end
  end
end
