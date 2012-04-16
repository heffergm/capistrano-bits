
# where's the lockfile go 
set :deploy_lockfile, "/tmp/lock_file.txt"

# lock deploy, :migrations, :pre_migrations
%w(deploy).each do |lock|
  before(lock.to_sym, 'deploy:lock'.to_sym)
end

# update, cleanup, run puppet, unlock
after "deploy:update", "deploy:cleanup", "deploy:unlock"

 
  # create deploy lockfiles
  desc "Lock 'er down!"
  task :lock, :roles => :app do
    check_lock
    logger.info "\e[0;31;1mNOTICE:\e[0m Creating deploy lockfile..."
    msg = fetch(:lock_message, 'Cap generated lock message')
    timestamp = Time.now.strftime("%m/%d/%Y %H:%M:%S %Z")
    lock_message = "Deploys locked by #{ENV['USER']} at #{timestamp}: #{msg}"
    put lock_message, "#{deploy_lockfile}", :mode => 0664
  end

  # check for lockfiles
  desc "Check if deploys are OK here or if someone has locked down deploys"
  task :check_lock, :roles => :app do
    run "cat #{deploy_lockfile};echo" do |ch, stream, data|
      if data =~ /Deploys locked by/
        logger.info "\e[0;31;1mABORTING:\e[0m #{data}"
        abort 'Deploys are locked on this machine'
      else
      end
    end
  end

  # remove lockfiles
  desc "Remove the deploy lock"
  task :unlock, :roles => :app do
    logger.info "\e[0;31;1mNOTICE:\e[0m Removing deploy lockfile..."
    run "rm -f #{deploy_lockfile}; echo"
  end


