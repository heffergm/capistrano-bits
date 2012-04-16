## how many of our hosts to restart at once
set :concurrent_restarts, 2

## :do stuff... specifically, restart x hosts, defined by concurrent_restarts
namespace :do do
  servers = find_servers_for_task(current_task)

  # restart imagine
  task :restart, :roles => :app do
    servers = find_servers_for_task(current_task)
    servers.each_slice(concurrent_restarts) do |group|
      filter_hosts(group) do
        logger.info "\e[0;31;1mNOTICE:\e[0m Restarting for #{group}"
        run "some commands you use to restart your app", :hosts => group
      end
    end
  end
end

