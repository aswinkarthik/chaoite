# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chaoite/version'

Gem::Specification.new do |spec|
  spec.name          = "chaoite"
  spec.version       = Chaoite::VERSION
  spec.authors       = ["Aswin"]
  spec.email         = ["aswinkarthik93@gmail.com"]

  spec.summary       = "A collector and reporter for Graphite"
  spec.description   = "A monitoring data collector that can poll services over http or run shell commands and gather a variety of metrics. Works with JSON/XML based services too, with support for jsonpath/xpath."
  spec.homepage      = "https://github.com/aswinkarthik93/chaoite"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "json", "~> 1.8"
  spec.add_runtime_dependency "jsonpath", "~> 0.5"
  spec.add_runtime_dependency "graphite-api", "~> 0.1"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
end
