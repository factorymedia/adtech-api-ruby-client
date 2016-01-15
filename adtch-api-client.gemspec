$: << File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'adtech-api-client'
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['minsikzzang']
  s.email       = ['min.kim@factorymedia.com', 'minsikzzang@gmail.com']
  s.homepage    = 'http://www.factorymedia.com'
  s.summary     = 'ADTech Classic API ruby client'
  s.description = 'ADTech Classic API ruby client'

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']
end
