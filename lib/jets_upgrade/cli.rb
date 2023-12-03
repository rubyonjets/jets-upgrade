module JetsUpgrade
  class CLI < Command
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean

    desc "go", "Run jets upgrade script"
    long_desc Help.text(:go)
    option :javascript, type: :boolean, default: true, desc: "Upgrade javascript files"
    option :yes, type: :boolean, aliases: :y, default: false, desc: "By pass are you sure prompt"
    def go
      Go.new(options).run
    end

    desc "version", "prints version"
    def version
      puts VERSION
    end
  end
end
