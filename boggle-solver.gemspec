# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "boggle-solver/version"

Gem::Specification.new do |spec|
  spec.name          = "boggle-solver"
  spec.version       = Boggle::Solver::VERSION
  spec.authors       = ["Anthony Good"]
  spec.email         = ["good.anthony@gmailc.om"]
  spec.description   = %q{A library for generating and solving boggle grids.}
  spec.summary       = %q{Boggle-related utilities.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rspec'
end