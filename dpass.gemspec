# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dpass/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Spikels"]
  gem.email         = ["spikels@infoaccess.org"]
  gem.description   = %q{Derive application specific passwords from secret master password using PBKDF2 in OpenSSL}
  gem.summary       = %q{Derive application specific passwords}
  gem.homepage      = "https://github.com/Spikels/dpass"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "dpass"
  gem.require_paths = ["lib"]
  gem.version       = Dpass::VERSION

  gem.add_development_dependency('rspec')
end
