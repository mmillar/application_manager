set :application, "torstardev.verto.ca"

# deploying users must be in deployers group
before 'deploy:update_code', 'config_mgmt:permissions'

namespace :config_mgmt do
  desc 'Set permissions'
  task :permissions do
    run "#{sudo} chgrp -R deploy #{shared_path}/*"
    run "#{sudo} chmod -R g+w #{shared_path}/*"
    run "#{sudo} chmod -R +r #{shared_path}/log/"
  end
end

