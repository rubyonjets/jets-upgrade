class JetsUpgrade::Javascript
  class Move < Base
    def run
      Dir.glob("app/javascript/packs/*").each do |src|
        if src.ends_with?(".js")
          dest = src.sub("app/javascript/packs/", "app/javascript/")
        else # css or scss
          dest = src.sub("app/javascript/packs/", "app/assets/stylesheets/")
        end
        FileUtils.mkdir_p(File.dirname(dest))
        FileUtils.mv(src, dest)
        puts "Moved #{src} => #{dest}"
      end
      remove_empty_dir("app/javascript/packs")
    end

    def self.run
      new.run
    end
  end
end
