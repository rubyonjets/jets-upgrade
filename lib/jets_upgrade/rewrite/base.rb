module JetsUpgrade::Rewrite
  # interface methods:
  # marker
  # filename
  # new_content
  class Base
    extend Memoist

    def lines
      IO.readlines(filename)
    end
    memoize :lines

    def run
      unless File.exist?(filename)
        puts "File does not exist: #{filename}".color(:red)
        return
      end

      found = lines.detect { |l| l.include?(marker) }
      if found
        puts "#{filename} looks good".color(:green)
        return
      end

      # puts content
      rewrite
    end

    def rewrite
      IO.write(filename, content)
      puts "Updated #{filename}"
    end

    def self.run
      new.run
    end
  end
end
