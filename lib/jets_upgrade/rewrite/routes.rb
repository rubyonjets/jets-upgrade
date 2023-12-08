module JetsUpgrade::Rewrite
  class Routes < Base
    def filename
      "config/routes.rb"
    end

    def marker
      "# updated by jets upgrade"
    end

    def content
      modified_lines = lines.map do |line|
        if line =~ /root "jets\/public#show"/
          line = line.sub('jets/public#show', 'jets/welcome#index')
        end
        line
      end
      modified_lines << "\n#{marker}\n"
      modified_lines.join('')
    end
  end
end
