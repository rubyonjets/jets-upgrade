class JetsUpgrade::CLI
  class Go
    def initialize(options)
      @options = options
    end

    def run
      sure?
      JetsUpgrade::Rewrite.run(@options)
      JetsUpgrade::PublicIndex.run
      JetsUpgrade::Javascript.run if @options[:javascript]
      JetsUpgrade::Iam.run
      finish_message
    end

    def finish_message
      puts <<~EOL
        Upgrade complete! Please double check the files to make sure they look correct.
        Remember, this is a best-effort upgrade tool. It does not cover all cases.

        Try running:

      EOL
      puts "    jets server".color(:green)
      puts
    end

    def sure?
      return if @options[:yes]
      puts <<~EOL
        This script will make changes to your project source code.

        Note: It's unfeasible to account for all cases and Jets apps.
        This script cannot perform miracle upgrades. It's a best-effort script,
        and the hope is that this script gets you pretty far and is helpful. 😄

        Please make sure you have backed up and committed your changes first.
        Are you sure you want to continue?

      EOL
      unless agree("Continue? (y/n)")
        puts "Exiting without making changes."
        exit
      end
    end

    def agree(prompt)
      print(prompt + " ")
      $stdin.gets.chomp.downcase =~ /^y/
    end
  end
end
