# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'neco/version'

Gem::Specification.new do |spec|
  spec.name          = 'neco'
  spec.version       = Neco::VERSION
  spec.authors       = ['OKURA Masafumi']
  spec.email         = ['masafumi.o1988@gmail.com']

  spec.summary       = 'neco is a NEo COmmand object library.'
  spec.description   = <<~DESC
    neco provides an elegant interface for commands.
    You can validate input, handle errors and compose multiple commands with rollback.
  DESC
  spec.homepage      = 'https://github.com/okuramasafumi/neco'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry', '>= 0.12.2'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rubocop', '>= 0.70.0'
end
