# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hyperloop/component/version'

Gem::Specification.new do |spec|
  spec.name          = 'hyper-component'
  spec.version       = Hyperloop::Component::VERSION
  spec.authors       = ['catmando','janbiedermann']
  spec.email         = ['mitch@catprint.com']

  spec.summary       = %q{The Hyperloop rendering engine.  Write React components in Ruby.}
  spec.homepage      = 'http://ruby-hyperloop.org'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'actionview', '~> 5.1.4'
  spec.add_dependency 'hyper-react', '0.15.0-sachsenring-lap5'
  spec.add_dependency 'hyperloop-config', '0.15.0-sachsenring-lap5'
  spec.add_dependency 'opal-rails', '~> 0.9.3'
  spec.add_dependency 'react-rails', '>= 2.3.0', '< 2.5.0'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'hyper-spec', '0.15.0-sachsenring-lap5'
  spec.add_development_dependency 'listen'
  spec.add_development_dependency 'opal', '~> 0.10.5'
  spec.add_development_dependency 'opal-browser', '~> 0.2.0'
  spec.add_development_dependency 'rails', '~> 5.1.4'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.7.0'
  spec.add_development_dependency 'rspec-steps', '~> 2.1.1'
  spec.add_development_dependency 'rubocop', '~> 0.51.0'
  spec.add_development_dependency 'sqlite3'
end
