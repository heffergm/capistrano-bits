
  ## set max_hosts 20 or via env
  set :max_hosts, ENV['MAXHOSTS'] || 20

  ## set max_hosts on update_code
  task :update_code, :except => { :no_release => true }, :max_hosts => "#{max_hosts}" do
    logger.info "\e[0;31;1mNOTICE:\e[0m Pulling repo from #{repository}: max_hosts => '#{max_hosts}'"
    on_rollback { run "rm -rf #{release_path}; true" }
    strategy.deploy!
    finalize_update
  end

