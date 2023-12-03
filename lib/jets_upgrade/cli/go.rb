class JetsUpgrade::CLI
  class Go
    def initialize(options)
      @options = options
    end

    def run
      JetsUpgrade::Rewrite.run
      JetsUpgrade::PublicIndex.run
    end
  end
end
