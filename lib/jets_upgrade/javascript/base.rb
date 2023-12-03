class JetsUpgrade::Javascript
  class Base
    def remove_empty_dir(path)
      return unless Dir.exist?(path)
      if Dir.empty?(path)
        FileUtils.rmdir(path)
        puts "Removed empty dir #{path}"
      end
    end
  end
end
