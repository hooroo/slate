lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slate/version'

Gem::Specification.new do |spec|
  spec.name          = 'slate'
  spec.version       = Slate::VERSION
  spec.authors       = ['Rob Monie']
  spec.email         = ['robmonie@gmail.com']
  spec.summary       = %q{Logging and metrics capturing utils.}
  spec.description   = %q{}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'log4r'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'celluloid', '~> 0.15'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'timecop', '~> 0.7.3'
  spec.add_development_dependency 'hitimes', '~> 1.2.3' #For some reason CI is not detecting this dependency from celluloid when it installs.
end
