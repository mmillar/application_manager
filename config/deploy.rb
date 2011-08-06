# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
require "bundler/capistrano"

set :repository,  "git@github.com:mmillar/application_manager.git"

set :scm, :git
set :deploy_via, :remote_cache
set :user, 'deploy'
set :deploy_to, '/www/application_manager'
set :branch, "master"
set :rails_env, "production"
set :rvm_ruby_string, "1.9.2@application_manager"

default_run_options[:pty] = true

role :app, "torstar.verto.ca"
role :web, "torstar.verto.ca"
role :db, "torstar.verto.ca", :primary => true

namespace :deploy do
  desc 'Restarting Phusion Passenger.'
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

desc "tail production log files"
task :tail_logs, :roles => :app do
  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}"
    break if stream == :err
  end
end

