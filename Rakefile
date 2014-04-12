require "bundler/gem_tasks"
require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new do |test|
  test.test_files = Dir['test/**/test_*.rb']
end
