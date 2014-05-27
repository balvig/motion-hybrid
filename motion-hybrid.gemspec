# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'motion-hybrid/version'

Gem::Specification.new do |spec|
  spec.name          = "motion-hybrid"
  spec.version       = MotionHybrid::VERSION
  spec.authors       = ["Jens Balvig"]
  spec.email         = ["jens@balvig.com"]
  spec.summary       = %q{RubyMotion framework for easily making hybrid webview-centric iOS apps}
  spec.description   = %q{RubyMotion framework for easily making hybrid webview-centric iOS apps}
  spec.homepage      = "https://github.com/balvig/motion-hybrid"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'bubble-wrap'
  spec.add_dependency 'dish'
  spec.add_dependency 'motion-cocoapods'
  spec.add_dependency 'motion-require'
  spec.add_dependency 'motion-support'
  spec.add_dependency 'ProMotion'
  spec.add_dependency 'sugarcube'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'motion-redgreen'
  spec.add_development_dependency 'webstub'
end
