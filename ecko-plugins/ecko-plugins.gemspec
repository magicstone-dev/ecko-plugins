
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ecko/plugins/version'

Gem::Specification.new do |spec|
  spec.name          = 'ecko-plugins'
  spec.version       = Ecko::Plugins::VERSION
  spec.authors       = ['Manish Sharma']
  spec.email         = ['arnoltherasing@gmail.com']

  spec.summary       = 'Adds plugin functionality to Ecko and other Mastodon-based servers'
  spec.description   = 'We can register plugins through the registry provided by Ecko-plugins'
  spec.homepage      = 'https://github.com/magicstone-dev/ecko-plugins/tree/main/ecko-plugins'
  spec.license       = 'GPL-3.0+'
  spec.files         = Dir['lib/**/*.rb'].to_a

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = spec.homepage
    spec.metadata['changelog_uri'] = spec.homepage
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # Not required now since specs are not there yet
  # Will add a configuration later to omit this in docker compose.
  # spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
