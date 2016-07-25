# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fuzy_iron/version'

Gem::Specification.new do |spec|
  spec.name          = 'fuzy_iron'
  spec.version       = FuzyIron::VERSION
  spec.authors       = ['Som Poddar']
  spec.email         = ['som.poddar@gmail.com']

  spec.summary       = 'FuzzyIron will help flood any Iron.io MQ easily with custom payload.'
  spec.description   = 'FuzzyIron will help flood any Iron.io MQ easily with custom payload.'
  spec.homepage      = 'http://www.sombit.com'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://mygemserver.com'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'iron_mq'
end
