# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'statkit/version'

Gem::Specification.new do |spec|
  spec.name          = "statkit"
  spec.version       = Statkit::VERSION
  spec.authors       = ["Yuto Hayamizu"]
  spec.email         = ["y.hayamizu@gmail.com"]

  spec.summary       = %q{Command line statistical analysis kit}
  spec.description   = %q{Command line statistical analysis kit}
  spec.homepage      = "https://github.com/hayamiz/statkit"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
