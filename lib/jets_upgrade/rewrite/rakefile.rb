module JetsUpgrade::Rewrite
  class Rakefile < Base
    def filename
      "Rakefile"
    end

    def marker
      "Jets.application.load_tasks"
    end

    def content
      modified_lines = lines.map do |line|
        if line.match(/Jets\.load_tasks/)
          "Jets.application.load_tasks\n"
        else
          line
        end
      end.compact
      modified_lines.join('')
    end
  end
end
