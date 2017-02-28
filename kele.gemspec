lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name          = 'kele'
  s.version       = '0.0.1'
  s.date          = '2017-02-22'
  s.summary       = 'Kele API Client'
  s.description   = 'A client for the Bloc API'
  s.authors       = ['Cord Wartman']
  s.email         = 'cordwartman@gmail.com'
  s.files         = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_paths = "lib"
  s.homepage      = 'http://rubygems.org/gems/kele'
  s.license       = 'MIT'
  s.add_runtime_dependency 'rest-client', '~> 2.0'
  s.add_runtime_dependency 'json', '~> 2.0'
end
