$: << File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'adtech-api-client'
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['minsikzzang']
  s.email       = ['min.kim@factorymedia.com', 'developers@factorymedia.com']
  s.homepage    = 'https://github.com/factorymedia/adtech-api-ruby-client'
  s.summary     = 'ADTech Classic API ruby client'
  s.description = 'ADTech Classic API ruby client'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
end
