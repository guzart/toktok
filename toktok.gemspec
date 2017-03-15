# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'toktok/version'

Gem::Specification.new do |spec|
  spec.name          = 'toktok'
  spec.version       = Toktok::VERSION
  spec.authors       = ['Arturo Guzman']
  spec.email         = ['arturo@guzart.com']

  spec.summary       = 'Simplify JWT token encoding and decoding for Ruby'
  spec.description   = <<~DOC
    Simplify JWT token encoding and decoding for Ruby. Use a configuration initializer to standardize the use
    of JWT encoding/decoding accross your library. Simplifies the use of JWT Claims.
  DOC
  spec.homepage      = 'https://github.com/guzart/toktok'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'jwt', '~> 1.5'

  spec.add_development_dependency 'awesome_print', '~> 1.7'
  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'codecov', '~> 0'
  spec.add_development_dependency 'guard', '~> 2.14'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'reek', '~> 4.5'
  spec.add_development_dependency 'rspec', '~> 3.5'
end
