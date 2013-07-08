#set :application, "set your application name here"
#set :repository,  "set your repository location here"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

require 'bundler/capistrano'
#require 'sidekiq/capistrano'
set :application, "tv_show"
set :rails_env, "production"
set :repository, "https://github.com/abooyaya/show_crawl_v2.git"
set :scm, "git"
set :user, "deploy" # 一個伺服器上的帳戶用來放你的應用程式，不需要有sudo權限，但是需要有權限可以讀取Git repository拿到原始碼
set :port, "22022"
set :deploy_to, "/home/deploy/tv_show"
set :deploy_via, :remote_cache
set :use_sudo, false
role :web, "106.187.53.220"
role :app, "106.187.53.220"
role :db, "106.187.53.220", :primary => true
set :default_environment, {
'PATH' => "/opt/ruby/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
}
set :assets_dependencies, %w(app/assets lib/assets vendor/assets Gemfile.lock config/routes.rb)
namespace :deploy do
task :copy_config_files do
db_config = "#{shared_path}/config/database.yml.production"
run "cp #{db_config} #{release_path}/config/database.yml"
end

task :update_symlink do
run "ln -s {shared_path}/public/system {current_path}/public/system"
end

task :start do ; end
task :stop do ; end
task :restart, :roles => :app, :except => { :no_release => true } do
run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
end
end
before "deploy:assets:precompile", "deploy:copy_config_files" # 如果將database.yml放在shared下，請打開
after "deploy:update_code", "deploy:copy_config_files" # 如果將database.yml放在shared下，請打開

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end