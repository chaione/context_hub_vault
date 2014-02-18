# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'context_hub_vault/version'

Gem::Specification.new do |spec|
  spec.name          = 'context_hub_vault'
  spec.version       = ContextHubVault::VERSION
  spec.authors       = ['Robert Boone']
  spec.email         = ['robert@chaione.com']
  spec.description   = %q{Ruby client for the ContextHUB Vault }
  spec.summary       = spec.description
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'

  spec.add_dependency 'httparty', '~> 0.10'
end
