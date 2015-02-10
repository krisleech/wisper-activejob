# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wisper/active_job/version'

Gem::Specification.new do |spec|
  spec.name          = "wisper-activejob"
  spec.version       = Wisper::ActiveJob::VERSION
  spec.authors       = ["Kris Leech"]
  spec.email         = ["kris.leech@gmail.com"]
  spec.summary       = "Provides Wisper with asynchronous event publishing using ActiveJob"
  spec.description   = "Provides Wisper with asynchronous event publishing using ActiveJob"
  spec.homepage      = "https://github.com/krisleech/wisper-activejob"

  spec.required_ruby_version = '>= 1.9.3'

  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'wisper'
  # spec.add_dependency 'activejob'
  spec.add_dependency 'rails', '>= 4.2'
end
