set :application, "Talebin"
set :deploy_to,  "/var/www/talebin.com"
server "106.186.120.146", :web, :app, :db, :primary => true
set :user, "webmaster"
#set :deploy_to,  "/home/arashvps/beta.talebin.com"
set :use_sudo, false

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git@github.com:tectual/talebin.git"  # Your clone URL
set :scm, "git"
ssh_options[:forward_agent] = true
set :branch, "master"
set :deploy_via, :remote_cache

##default_environment['PATH'] = '~/.gems/bin:$PATH'
##default_environment['GEM_PATH'] = '~/.gems'

namespace :bundle do

  task :install do
    run "cd #{current_path} && bundle install  --without=test"
  end

end
##before "deploy:restart", "bundle:install"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    ##set :bundle_cmd, 'source $HOME/.bash_profile && bundle'
    #run "cd #{release_path} && bundle"
    ##run "cd #{release_path};"
    #run "cd #{release_path}; bundle exec rake assets:precompile RAILS_ENV=production RAILS_GROUPS=assets"
    ##run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end




before "deploy:create_symlink", "symlinks:create"
namespace :symlinks do
  task :create, :roles => :app do
    run "cd #{release_path}/public && rm system -rf"
    #run "cd #{release_path}/public && ln -s ~/new.talebin.com/shared/system system"
    run "cd #{release_path}/public && ln -s #{shared_path}/system system"
  end
end



# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

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
