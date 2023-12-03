# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jets_upgrade/version"

Gem::Specification.new do |spec|
  spec.name          = "jets-upgrade"
  spec.version       = JetsUpgrade::VERSION
  spec.authors       = ["Tung Nguyen"]
  spec.email         = ["tongueroo@gmail.com"]
  spec.summary       = "Jets Upgrade Tool"
  spec.homepage      = "https://github.com/rubyonjets/jets-upgrade"
  spec.license       = "MIT"

  spec.files         = File.directory?('.git') ? `git ls-files`.split($/) : Dir.glob("**/*")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "memoist"
  spec.add_dependency "rainbow"
  spec.add_dependency "thor"
  spec.add_dependency "zeitwerk"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
