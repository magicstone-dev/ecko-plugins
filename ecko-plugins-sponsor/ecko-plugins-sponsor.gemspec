# frozen_string_literal: true

require_relative "lib/ecko/plugins/sponsor/version"

Gem::Specification.new do |spec|
  spec.name = 'ecko-plugins-sponsor'
  spec.version = Ecko::Plugins::Sponsor::VERSION
  spec.authors = ['Manish Sharma']
  spec.email = ['arnoltherasing@gmail.com']

  spec.summary = 'Adds sponsor functionality through donations'
  spec.description = 'Adds mastodon functionality to donate to an instance and sponsorship tags'
  spec.homepage = 'https://github.com/magicstone-dev/ecko-plugins/tree/main/ecko-plugins-sponsor'
  spec.license = 'GPL-3.0+'
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  spec.files = Dir['lib/**/*.rb', 'app/**/*.rb'].to_a

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib app]
  spec.add_dependency 'ecko-plugins', '~> 0.1.6'
  spec.add_dependency 'rails', '>= 6.1.4', '< 7.0.0'
end
