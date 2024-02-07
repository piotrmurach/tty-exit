require_relative "lib/tty/exit/version"

Gem::Specification.new do |spec|
  spec.name          = "tty-exit"
  spec.version       = TTY::Exit::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["piotr@piotrmurach.com"]
  spec.summary       = %q{Terminal exit codes for humans and machines}
  spec.description   = %q{Terminal exit codes for humans and machines}
  spec.homepage      = "https://ttytoolkit.org"
  spec.license       = "MIT"
  if spec.respond_to?(:metadata=)
    spec.metadata = {
      "allowed_push_host" => "https://rubygems.org",
      "bug_tracker_uri"   => "https://github.com/piotrmurach/tty-exit/issues",
      "changelog_uri"     => "https://github.com/piotrmurach/tty-exit/blob/master/CHANGELOG.md",
      "documentation_uri" => "https://www.rubydoc.info/gems/tty-exit",
      "funding_uri"       => "https://github.com/sponsors/piotrmurach",
      "homepage_uri"      => spec.homepage,
      "source_code_uri"   => "https://github.com/piotrmurach/tty-exit"
    }
  end
  spec.files         = Dir["lib/**/*", "README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.extra_rdoc_files = ["README.md", "CHANGELOG.md"]
  spec.bindir        = "exe"
  spec.require_paths = ["lib"]
  spec.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
end
