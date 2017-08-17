# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rosetta_search/version'

Gem::Specification.new do |spec|
  spec.name          = "rosetta_search"
  spec.version       = RosettaSearch::VERSION
  spec.authors       = ["'Mariel F'"]
  spec.email         = ["'marielbeth@gmail.com'"]

  spec.summary       = %q{A command line application that provides translations for up to four languages at a time and detailed translations of specific words.}
  spec.description   = %q{This gem enables you to translate a word or phrase into up to four languages at the same time using Ruby and Google Cloud Translation API. Further translation information (including example usage) for individual words in some languages is provided through scraping wordreference.com with Nokogiri and Open-URI.}
  spec.homepage      = "https://github.com/marielfrank/rosetta-search-cli-app"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end
