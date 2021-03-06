require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'fileutils'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :console do
  require 'pry'
  require 'context_hub_vault'
  ARGV.clear
  Pry.start
end

def remote_name
  ENV.fetch('REMOTE_NAME', 'origin')
end

PROJECT_ROOT = `git rev-parse --show-toplevel`.strip
BUILD_DIR    = File.join(PROJECT_ROOT, 'doc')
GH_PAGES_REF = File.join(BUILD_DIR, '.git/refs/remotes/#{remote_name}/gh-pages')

directory BUILD_DIR

file GH_PAGES_REF => BUILD_DIR do
  repo_url = nil

  cd PROJECT_ROOT do
    repo_url = `git config --get remote.#{remote_name}.url`.strip
  end
end

# Alias to something meaningful
task prepare_git_remote_in_build_dir: GH_PAGES_REF

# Fetch upstream changes on gh-pages branch
task :sync do
  cd BUILD_DIR do
    sh 'git fetch #{remote_name}'
    sh 'git reset --hard #{remote_name}/gh-pages'
  end
end

# Prevent accidental publishing before committing changes
task :not_dirty do
  puts '***#{ENV[\'ALLOW_DIRTY\']}***'
  unless ENV['ALLOW_DIRTY']
    fail 'Directory not clean' if /nothing to commit/ !~ `git status`
  end
end

desc 'Compile all files into the docs directory'
task :build_docs do
  cd PROJECT_ROOT do
    sh 'yard'
  end
end

desc 'Build and publish to Github Pages'
task publish_docs: [:not_dirty, :prepare_git_remote_in_build_dir, :sync, :build_docs] do
  message = nil
  suffix = ENV['COMMIT_MESSAGE_SUFFIX']

  cd PROJECT_ROOT do
    head = `git log --pretty='%h' -n1`.strip
    message = ["Site updated to #{head}", suffix].compact.join('\n\n')
  end

  cd BUILD_DIR do
    sh 'git add --all'
    if /nothing to commit/ =~ `git status`
      puts 'No changes to commit.'
    else
      sh 'git commit -m "#{message}"'
    end
    sh 'git push #{remote_name} gh-pages'
  end
end
