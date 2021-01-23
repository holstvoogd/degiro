lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'degiro/version'

Gem::Specification.new do |spec|
  spec.name          = 'degiro'
  spec.homepage      = 'https://github.com/vaneyckt/degiro'
  spec.licenses      = ['MIT']
  spec.version       = DeGiro::VERSION
  spec.description   = 'Ruby Client for the unofficial DeGiro API'
  spec.summary       = 'Ruby Client for the unofficial DeGiro API'
  spec.authors       = ['Tom Van Eyck']
  spec.email         = ['tomvaneyck@gmail.com']

  spec.files         = Dir.glob('lib/**/*.rb')
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.13.1'
  spec.add_dependency 'faraday-cookie_jar', '~> 0.0.6'
  spec.add_dependency 'monetize'

  spec.add_development_dependency 'rubocop', '~> 0.51.0'
end
