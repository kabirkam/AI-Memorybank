# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

task :purge => [:load_config] do
  ActiveRecord::Tasks::DatabaseTasks.purge_current
end

Rails.application.load_tasks
