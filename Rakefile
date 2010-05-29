# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

# require the hydra codebase
require 'hydra'
# require the hydra rake task helpers
require 'hydra/tasks'

# set up a new hydra testing task named 'hydra:units' run with "rake hydra:units"
Hydra::TestTask.new('hydra:units') do |t|
  # add all files in the test/unit directory recursively that
  # end with "_test.rb"
  t.add_files 'test/unit/**/*_test.rb'
  # and test/functional
  t.add_files 'test/functional/**/*_test.rb'
end