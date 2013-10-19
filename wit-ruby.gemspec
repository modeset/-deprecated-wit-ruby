$:.push File.expand_path('../lib', __FILE__)

require 'wit/version'

Gem::Specification.new do |s|
  s.name        = 'wit-ruby'
  s.version     = Wit::VERSION
  s.authors     = ['Jeremy Jackson']
  s.email       = ['info@modeset.com']
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/modeset/teaspoon'
  s.summary     = %Q{wit-ruby: Easy interface for wit.ai}
  s.description = %Q{A simple library for interacting with wit.ai -- will expand as the api does}

  s.files       = Dir['lib/**/*'] + ['MIT.LICENSE', 'README.md']
  s.test_files  = Dir['{spec}/**/*']

  s.add_dependency "faraday", ">= 0.8.8"
end
