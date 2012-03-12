# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ekey/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Dmitry Koprov"]
  gem.email         = ["dmitry.koprov@gmail.com"]
  gem.description   = %q{A ruby wrapper for API of the ekey.ru}
  gem.summary       = %q{A ruby wrapper for API of the ekey.ru}
  gem.homepage      = "https://github.com/dkoprov/ekey"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "ekey"
  gem.require_paths = ["lib"]
  gem.version       = Ekey::VERSION

  gem.add_dependency "json_pure"
  gem.add_dependency "rest-client"

end
