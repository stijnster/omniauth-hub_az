require_relative 'lib/omniauth/hub_az/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-hub_az"
  spec.version       = Omniauth::HubAz::VERSION
  spec.authors       = ["Stijn Mathysen"]
  spec.email         = ["stijn@skylight.be"]

  spec.summary       = %q{OmniAuth solution for hub_az.}
  spec.description   = %q{OmniAuth solution for hub_az.}
  spec.homepage      = "https://github.com/stijnster/omniauth-hub_az"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/stijnster/omniauth-hub_az"
  spec.metadata["changelog_uri"] = "https://github.com/stijnster/omniauth-hub_az/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'omniauth-oauth2', '~> 1.6'
end
