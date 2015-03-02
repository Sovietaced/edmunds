require "bundler/gem_tasks"
require "rake/testtask"
require 'coveralls/rake/task'

task :default => :test

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
end

Coveralls::RakeTask.new
