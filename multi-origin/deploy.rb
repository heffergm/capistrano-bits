
# set repo via env, github as default
if ENV['REPO'] == 'local'
  set :repository, "root@some.internalhost.com:/var/cache/git/repo.git"
else
  set :repository,  "git@github.com:brewster/repo.git"
end

# update origin in case we need to deploy from a diff location
task :update_origin, :roles => :app do
  logger.info "\e[0;31;1mNOTICE:\e[0m Updating remote origin..."
  run "[[ -d #{shared_path}/cached-copy ]] && cd #{shared_path}/cached-copy && git remote set-url origin #{repository} || true"
end
before :"deploy:update_code", :update_origin

