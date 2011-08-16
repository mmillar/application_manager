set :application, "torstar.verto.ca"

# deploying users must be in deployers group
before 'deploy:update_code', 'config_mgmt:permissions'
after 'deploy:symlink', 'config_mgmt:configs'

namespace :config_mgmt do
  desc 'Set permissions'
  task :permissions do
    run "#{sudo} chgrp -R deploy #{shared_path}/*"
    run "#{sudo} chmod -R g+w #{shared_path}/*"
    run "#{sudo} chmod -R +r #{shared_path}/log/"
  end
  task :configs do
    run "#{sudo} cp -a #{shared_path}/database.yml #{current_path}/config/database.yml"
  end
end

