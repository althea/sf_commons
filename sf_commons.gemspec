# -*- encoding: utf-8 -*-
require File.expand_path("../lib/sf_commons/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "sf_commons"
  s.version     = SfCommons::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Platform team"]
  s.homepage    = "http://github.com/althea/sf_commons.git"
  s.description = s.summary  = %q{commons extracted out...}

  s.rubyforge_project = "sf_commons"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.require_paths = ["lib"]

  s.add_runtime_dependency(%q<addressable>)

  s.add_development_dependency('rspec')
  s.add_development_dependency('rake')
  s.add_development_dependency('bundler')
end
