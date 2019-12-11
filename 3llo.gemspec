# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require '3llo/version'

Gem::Specification.new do |spec|
  spec.name = '3llo'
  spec.version = Tr3llo::VERSION
  spec.authors = ['Cẩm Huỳnh']
  spec.email = ['huynhquancam@gmail.com']

  spec.summary = 'Trello CLI'
  spec.description = 'CLI for Trello'
  spec.homepage = 'https://github.com/qcam/3llo'
  spec.license = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/|intro\.gif}) }
  spec.bindir = 'bin'
  spec.executables = spec.files.grep(%r{^bin/}) { |filename| File.basename(filename) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '~> 2.0'

  spec.add_runtime_dependency 'tty-prompt', '~> 0.12.0'

  spec.add_development_dependency 'rspec', '~> 3.0'
end
