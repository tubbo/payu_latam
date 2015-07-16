# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'payu/version'

Gem::Specification.new do |spec|
  spec.name          = "payu_latam"
  spec.version       = Payu::VERSION
  spec.authors       = ["Gonzalo Aguirre"]
  spec.email         = ["gonzaloa@idea.me"]
  spec.description   = "PayU SDK in Ruby for Payments API and Reports API"
  spec.summary       = "SDK in Ruby for PayU Latam APIs"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
