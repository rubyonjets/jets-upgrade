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
      within_destroy = false
      modified_lines = lines.map do |line|
        if line =~ /\s{2,}def delete$/
          line = line.sub('delete', 'destroy')
          within_destroy = true
        end
        if within_destroy
          if line =~ /\s{2,}redirect_to (\w+)$/
            location_method = $1 # IE: posts_path
            line = respond_to_code(location_method)
          end
        end
        if within_destroy && line =~ /\s{2,}end$/
          within_destroy = false
        end

        if line =~ /before_action :/ && line =~ /delete/
          line = line.sub('delete', 'destroy')
        end
        line
      end
      modified_lines.join('')
    end

    def respond_to_code(location_method)
      code = <<~EOL
        respond_to do |format|
          format.html { redirect_to #{location_method} }
          format.js   { render json: { location: #{location_method} } }
        end
      EOL
      lines = code.split("\n")
      # add 4 spaces to each line
      lines.map! { |line| "    #{line}" }.join("\n") + "\n"
    end
  end
end
