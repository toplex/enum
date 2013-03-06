# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "yinum"
  s.version     = "1.1.0"
  s.authors     = ["Oded Niv"]
  s.email       = ["oded.niv@gmail.com"]
  s.homepage    = "https://github.com/toplex/enum"
  s.summary     = %q{Enum implementation}
  s.description = %q{Yummy implementation of enum that gives integer values with a special wrapping.}

  s.rubyforge_project = "yinum"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
