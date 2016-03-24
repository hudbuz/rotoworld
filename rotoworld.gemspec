# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rotoworld/version'

Gem::Specification.new do |spec|
  spec.name          = "rotoworld"
  spec.version       = Rotoworld::VERSION
  spec.authors       = ["hudbuz"]
  spec.email         = ["hzb2@cornell.edu"]

  spec.summary       = %q{This Gem gives you access to Rotoworld's NFL Player News information news feed with executable actions.}
  spec.homepage      = "https://github.com/hudbuz/rotoworld.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
 

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = "rotoworld"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "launchy"
end
