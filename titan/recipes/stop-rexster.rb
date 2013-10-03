# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

#
# start rexster
#

include_recipe "titan::rexster-service"

execute 'stop_rexster' do
    command '/bin/true'
    notifies :stop, resources(:service => 'rexster')
end

