require "bundler/gem_tasks"
task :default => :spec

namespace :range do
  desc "Generate registrant range files"
  task :generate do
    ruby "scripts/generate_range_files.rb --dir data"
  end
end
