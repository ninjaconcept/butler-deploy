# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'butler/deploy/version'

Gem::Specification.new do |spec|
  spec.name          = "butler-deploy"
  spec.version       = Butler::Deploy::VERSION
  spec.authors       = ["Stefan Botzenhart"]
  spec.email         = ["sb@ninjaconcept.com"]

  spec.summary       = %q{Setup fully working capistrano configuration using bundler, chruby and unicorn}
  spec.homepage      = "https://github.com/ninjaconcept/butler-deploy"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_development_dependency "capistrano-pending"
end
