lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fuzzycd/version'

Gem::Specification.new do |spec|
  spec.name          = 'fuzzycd'
  spec.authors       = ['Vincent Ho']
  spec.email         = ["vinmaster99@gmail.com"]
  spec.version       = Fuzzycd::VERSION
  spec.summary       = 'Fuzzy cd for the command line'
  spec.description   = 'Fuzzy cd for the command line'
  spec.homepage      = 'https://github.com/vinmaster/fuzzycd.rb'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']
  spec.bindir        = 'bin'
  spec.executables   = ['fuzzycd']

  spec.add_runtime_dependency 'tty', '~> 0.7.0'
  spec.add_development_dependency 'bundler', '~> 1.16', '>= 1.16.1'
  spec.add_development_dependency 'rake', '~> 12.3', '>= 12.3.0'
  spec.add_development_dependency 'rspec', '~> 3.7', '>= 3.7.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.6', '>= 3.6.0'
end
