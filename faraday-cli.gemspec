# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faraday/cli'

Gem::Specification.new do |spec|
  spec.name          = "faraday-cli"
  spec.version       = Faraday::CLI::VERSION
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]

  spec.summary       = %q{Console line interface for faraday gem.}
  spec.description   = %q{Console line interface for faraday gem client so you can use your favorite middleware based ruby http client on the terminal!}
  spec.homepage      = "https://github.com/adamluzsi/faraday-cli.rb"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
                           .select{|cli_command| cli_command =~ /^faraday\-cli/  }

  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.10'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'cucumber'

  spec.add_dependency 'commander'
  spec.add_dependency 'faraday'

end
