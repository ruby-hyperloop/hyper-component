# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hyperloop/component/version'

Gem::Specification.new do |spec|
  spec.name          = "hyper-component"
  spec.version       = Hyperloop::Component::VERSION
  spec.authors       = ["catmando"]
  spec.email         = ["mitch@catprint.com"]

  spec.summary       = %q{The Hyperloop rendering engine.  Write React components in Ruby.}
  spec.homepage      = "http://ruby-hyperloop.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'hyper-react', '>= 0.12.3'
  spec.add_dependency 'hyperloop-config', '>= 0.9.2'
  spec.add_dependency 'react-rails', '>= 2.3.0'
  spec.add_dependency 'opal-rails'
  spec.add_dependency 'actionview'

  spec.add_development_dependency 'hyper-spec'
  spec.add_development_dependency 'listen'
  spec.add_development_dependency 'opal'
  spec.add_development_dependency 'opal-browser'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-steps'
  spec.add_development_dependency 'sqlite3'

  # Keep linter-rubocop happy
  spec.add_development_dependency 'rubocop'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
