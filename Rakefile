require_relative "./sagan"

namespace :db do
  desc "create database"
  task :create do
    database = ActiveRecord.database_name
    exec("echo 'create database #{database};' | mysql")
  end

  desc "drop database"
  task :drop do
    database = ActiveRecord.database_name
    exec("echo 'drop database if exists #{database};' | mysql")
  end

  desc "load schema"
  task :schema_load do
    exec("mysql #{ActiveRecord.database_name} < sql/schema.sql")
  end

  desc "seed"
  task :seed do
    exec("mysql --local-infile #{ActiveRecord.database_name} < sql/seed.sql")
  end
end

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
  # no rspec available
end
