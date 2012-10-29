require 'bundler/capistrano'
load 'deploy/assets'

ssh_options[:forward_agent] = true

set :application,     "sravnim-ka"
set :deploy_server,   "lithium.locum.ru"
set :bundle_without,  [:development, :test]
set :user,            "hosting_igel84"
set :login,           "igel84"
set :use_sudo,        false
set :deploy_to,       "/home/#{user}/projects/#{application}"
set :unicorn_conf,    "/etc/unicorn/#{application}.#{login}.rb"
set :unicorn_pid,     "/var/run/unicorn/#{application}.#{login}.pid"
set :bundle_dir,      File.join(fetch(:shared_path), 'gems')
role :web,            deploy_server
role :app,            deploy_server
role :db,             deploy_server, :primary => true
set :rvm_ruby_string, "1.9.3"
set :rake,            "rvm use #{rvm_ruby_string} do bundle exec rake" 
set :bundle_cmd,      "rvm use #{rvm_ruby_string} do bundle"
set :scm,             :git
set :repository,      "git://github.com/igel84/sravnim-ka.git"

before "deploy:assets:precompile", :remove_paths, :set_links
after "deploy:update_code", :do_migrations

task :remove_paths, roles => :app do
  run "rm -rf #{release_path}/tmp"
end

task :set_links, roles => :app do
  links = {
    '/config/database.yml' => '/config/database.yml'
  }
  links.each do |from, destination|
    run "rm -rf #{release_path}#{destination}"
    run "ln -s #{shared_path}#{from} #{release_path}#{destination}"
  end
end

task :do_migrations, roles => :app do
  run "cd #{deploy_to}/current; rvm use #{rvm_ruby_string} do bundle exec rake RAILS_ENV=production db:migrate;bundle install --path ../../shared/gems"
end

before 'deploy:finalize_update', 'set_current_release'
task :set_current_release, :roles => :app do
    set :current_release, latest_release
end

set :unicorn_start_cmd, "(cd #{deploy_to}/current; rvm use #{rvm_ruby_string} do bundle exec unicorn_rails -Dc #{unicorn_conf})"

namespace :deploy do
  desc "Start application"
  task :start, :roles => :app do
    run unicorn_start_cmd
  end

  desc "Stop application"
  task :stop, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_start_cmd}"
  end
end

#after "deploy:update_code", :copy_database_config
#  task :copy_database_config, roles => :app do
#    db_config = "#{shared_path}/config/database.yml"
#    run "cp #{db_config} #{release_path}/config/database.yml"
#end

#before 'deploy:finalize_update', 'set_current_release'
#task :set_current_release, :roles => :app do
#    set :current_release, latest_release
#end

#before "deploy:assets:precompile" do
#  run ["ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"].join(" && ")
#end

#set :unicorn_start_cmd, "(cd #{deploy_to}/current; rvm use #{rvm_ruby_string} do bundle exec unicorn_rails -Dc #{unicorn_conf})"
#set :unicorn_start_cmd, "(cd #{deploy_to}/current; rvm use #{rvm_ruby_string} do bundle exec unicorn_rails -Dc #{unicorn_conf})" #;bundle install --path ../../shared/gems;bundle exec rake db:migrate RAILS_ENV=production;bundle exec unicorn_rails -Dc #{unicorn_conf})"

#stop
#bundle install --path ../../shared/gems
#[ -f "/var/run/unicorn/sravnim-ka.igel84.pid" ] && kill -QUIT `cat "/var/run/unicorn/sravnim-ka.igel84.pid"`
#start
#!!!!! current dir name
#ln -s /home/hosting_igel84/projects/sravnim-ka/releases/20121023102422 /home/hosting_igel84/projects/sravnim-ka/current;cd /home/hosting_igel84/projects/sravnim-ka/current
#bundle exec unicorn_rails -Dc "/etc/unicorn/sravnim-ka.igel84.rb"

# - for unicorn - #
#namespace :deploy do
#  desc "Start application"
#  task :start, :roles => :app do
#    run unicorn_start_cmd
#  end

#  desc "Stop application"
#  task :stop, :roles => :app do
#    run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
#    #[ -f /var/run/unicorn/mgtender.igel84.pid ] && kill -QUIT `cat /var/run/unicorn/mgtender.igel84.pid`
#    #start
#    #bundle exec unicorn_rails -Dc /etc/unicorn/mgtender.igel84.rb
#  end

# desc "Restart Application"
#  task :restart, :roles => :app do
#    run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_start_cmd}"
#  end
#end