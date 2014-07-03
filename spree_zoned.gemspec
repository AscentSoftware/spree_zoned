# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_zoned'
  s.version     = '2.3.0.beta'
  s.summary     = 'Spree Zoned'
  s.description = 'A gem to enable switching of the default Zone'
  s.required_ruby_version = '>= 2.1'

  s.author    = '200 Creative Ltd'
  # s.email     = 'you@example.com'
  s.homepage  = 'http://200creative.com'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.3.0.beta'
  s.add_dependency 'geoip2', '~> 0.0.2'
  s.add_dependency 'browser', '~> 0.6'
end
