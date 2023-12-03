$stdout.sync = true unless ENV["JETS_UPGRADE_STDOUT_SYNC"] == "0"

$:.unshift(File.expand_path("../", __FILE__))

require "jets_upgrade/autoloader"
JetsUpgrade::Autoloader.setup

require "active_support"
require "active_support/core_ext/string"
require "fileutils"
require "memoist"
require "rainbow/ext/string"

module JetsUpgrade
  class Error < StandardError; end
end
