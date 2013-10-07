# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-nested_models'
  s.version           = '0.0.1'
  s.description       = 'Ruby on Rails Nested Models extension for Refinery CMS'
  s.date              = '2013-10-04'
  s.summary           = 'Nested Models extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]
  s.authors           = ['Nick Bolt']

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.1.0'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.1.0'
  s.add_development_dependency 'poltergeist', '~> 1.4.1'
end
