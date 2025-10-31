# frozen_string_literal: true

require_relative 'lib/neco/version'

Gem::Specification.new do |spec|
  spec.name = 'neco'
  spec.version = Neco::VERSION
  spec.authors = ['OKURA Masafumi']
  spec.email = ['masafumi.o1988@gmail.com']

  spec.summary = 'neco is a NEo COmmand object library.'
  spec.description = <<~DESC
    neco provides an elegant interface for commands.
    You can validate input, handle errors and compose multiple commands with rollback.
  DESC
  spec.homepage = 'https://github.com/okuramasafumi/neco'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/ .github/ .rubocop.yml])
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ['lib']
end
