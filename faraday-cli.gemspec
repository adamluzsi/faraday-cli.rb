# coding: utf-8
VERSION = File.read(File.join(File.dirname(__FILE__),'VERSION')).strip

Gem::Specification.new do |spec|
  spec.name          = "faraday-cli"
  spec.version       = VERSION
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]
  spec.license       = 'Apache License 2.0'

  spec.summary       = %q{Console line interface for faraday gem.}
  spec.description   = %q{Console line interface for faraday gem client so you can use your favorite middleware based ruby http client on the terminal!}
  spec.homepage      = 'https://github.com/adamluzsi/faraday-cli.rb'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.bindir        = 'exec'
  spec.executables   = spec.files.grep(%r{^exec/}) { |f| File.basename(f) }

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'cucumber'

  spec.add_dependency 'faraday'
  spec.add_dependency 'pwd'

end
