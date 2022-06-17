Gem::Specification.new do |s|
  s.name          = 'logstash-filter-teamcymru'
  s.version       = '0.1.1'
  s.licenses      = ['Apache-2.0']
  s.summary       = 'Team Cymru IP reputation checker'
  s.description   = 'Team Cymru IP reputation checker'
  s.homepage      = 'https://github.com/summergaga/logstash-filter-teamcymru'
  s.authors       = ['summergaga']
  s.email         = ''
  s.require_paths = ['lib']

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api"
  s.add_runtime_dependency "watir"
  s.add_runtime_dependency "webdrivers"
  s.add_runtime_dependency "headless"
  s.add_development_dependency "logstash-devutils"
end