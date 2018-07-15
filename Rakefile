require "rake/testtask"

Dir.glob("tasks/*.rake").each { |r| import r }

Rake::TestTask.new do |tt|
  tt.test_files = FileList["test/**/*_test.rb"]
end

task :console do
  require "pry"

  # Require the sources
  require_relative "./akarlahg/akarlahg"

  Pry.start
end

task c: :console
