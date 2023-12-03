module JetsUpgrade::Rewrite
  # interface methods:
  # marker
  # filename
  # new_content
  class Base
    extend Memoist

    def initialize(options={})
      @options = options
    end

    def lines
      IO.readlines(filename)
    end
    memoize :lines

    def run
      unless File.exist?(filename)
        puts "File does not exist: #{filename}".color(:red)
        return
      end

      marker_found = lines.detect { |l| marker && l.include?(marker) }
      not_marker_found = lines.detect { |l| not_marker && l.include?(not_marker) }
      if marker_found && !not_marker_found
        puts "#{filename} looks good".color(:green)
        return
      end

      if ENV['DEBUG']
        puts "filename: #{filename}".color(:purple)
        puts "content:".color(:purple)
        puts content
      end
      rewrite
    end

    def marker
      nil
    end

    # optional interface method
    def not_marker
      nil
    end

    # optional interface method
    def message
      nil
    end

    def rewrite
      return unless changed?
      IO.write(filename, content)
      puts "Updated #{filename}"
      puts message if message
      true
    end

    def changed?
      content != lines.join('')
    end

    def self.run(options={})
      new(options).run
    end
  end
end
