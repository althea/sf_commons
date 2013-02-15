require 'bundler'
Bundler::GemHelper.install_tasks
require 'rspec/core/rake_task'

$LOAD_PATH.unshift 'lib'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec