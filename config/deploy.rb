require 'bundler/capistrano'
require 'capistrano/ext/multistage'
#require 'ruby-growl'
require 'thinking_sphinx/deploy/capistrano'

set :stages, %w(production)
set :default_stage, "production"


set :application, "trendhop"
set :repository,  "git@github.com:polman86/trendhop.git"
set :scm, "git"
set :deploy_via, :remote_cache
#set :git_enable_submodules, 1

set :branch, "master"
set :user, "deploy"
set :group, "deploy"
set :use_sudo, false
set(:rails_env) {"#{stage}"}
set :keep_releases, 5

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
# namespace :deploy do
#   desc "Restarting mod rails with resrat.txt"
#   task :restart, :roles => :app, :except => {:no_release => true} do
#     run "touch #{current_path}/tmp/restart.txt"
#   end



# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end

   [:start, :stop].each do |t|
     desc "#{t} task is a no-op with mod_rails"
     task t, :roles => :app do ; end
   end

   # task :symlink_in_shared_directories, :roles => :app, :except => {:no_symlink => true} do
   #   run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
   #   run "ln -nfs #{shared_path}/system #{release_path}/public/system"
   # end

   # task :ensure_shared_directories_created, :roles => :app do
   #   %w{config system}.each do |dir|
   #     run <<-CMD
   #     mkdir -p #{shared_path}/#{dir}
   #     CMD
   #   end
   # end

 end

 namespace :ts do
   desc "Configure Sphinx"
   task :conf do
     thinking_sphinx.configure
   end
   desc "Index Sphinx (update index)"
   task :in do
     thinking_sphinx.index
   end
   desc "Start Sphinx"
   task :start do
     thinking_sphinx.start
   end
   desc "Stop Sphinx"
   task :stop do
     thinking_sphinx.stop
   end
   desc "Restart Sphinx"
   task :restart do
     thinking_sphinx.restart
   end
   desc "Rebuild and configure Sphinx"
   task :rebuild do
     thinking_sphinx.rebuild
   end
 end


 after "deploy", "deploy:migrate"
 after "deploy", "deploy:cleanup"

 # Configure thinking sphinx
 after "deploy", "thinking_sphinx:stop"
 # after "deploy", "thinking_sphinx:configure"
 after "deploy", "thinking_sphinx:start"

#after "deploy:symlink","deploy:symlink_in_shared_directories"
 after "deploy:setup", "thinking_sphinx:shared_sphinx_folder"

