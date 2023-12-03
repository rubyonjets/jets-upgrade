module JetsUpgrade::Rewrite
  class ViewJs < Base
    def initialize(path)
      @path = path
    end

    def filename
      @path # /full/path/to/app/controllers/posts_controller.rb
    end

    def not_marker
      "javascript_pack_tag"
    end

    def content
      modified_lines = lines.map do |line|
        if line =~ /<%= javascript_pack_tag/
          line = line.sub('<%= javascript_pack_tag', '<%= javascript_include_tag')
        end
        if line =~ /<%= stylesheet_pack_tag/
          line = line.sub('<%= stylesheet_pack_tag', '<%= stylesheet_link_tag')
        end
        line
      end
      modified_lines.join('')
    end
  end
end
