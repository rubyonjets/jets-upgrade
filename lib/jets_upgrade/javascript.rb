module JetsUpgrade
  class Javascript
    def run
      Remove.run
      Move.run
      Gitignore.run
      rewrite_view_js
    end

    def rewrite_view_js
      changed = false
      Dir.glob("app/views/**/*").each do |path|
        next if File.directory?(path)
        changed ||= JetsUpgrade::Rewrite::ViewJs.new(path).run
      end
      puts note if changed
    end

    def note
      puts <<~EOL
        Rewrote files use javascript_include_tag and stylesheet_link_tag instead of javascript_pack_tag and stylesheet_pack_tag.
        Please double check the file to make sure it looks correct.

        This does not take you all the way to importmaps. It just gets rid of the webpacker logic.
        More info: https://rubyonjets.com/docs/assets/importmap/
        To set up importmaps, please run:

      EOL
      puts "    jets importmap:install".color(:green)
      puts
      puts "Note: If they are conflicts, you can probably overwrite them."
    end

    def self.run
      new.run
    end
  end
end
