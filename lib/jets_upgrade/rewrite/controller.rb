module JetsUpgrade::Rewrite
  class Controller < Base
    def initialize(path)
      @path = path
    end

    def filename
      @path # /full/path/to/app/controllers/posts_controller.rb
    end

    def marker
      "def destroy"
    end

    def content
      modified_lines = lines.map do |line|
        if line =~ /\s{2,}def delete$/
          line = line.sub('delete', 'destroy')
        end
        line
      end
      modified_lines.join('')
    end
  end
end
