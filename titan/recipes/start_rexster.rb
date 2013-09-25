# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

#
# start rexster
#

include_recipe "titan::rexster_service"

debug_flag = ( node['titan']['debug'] == true ? "-d" : "" )

execute 'start_rexster' do
    command '/bin/true'
    environment ({ "$REXTER_SERVICE_DEBUG" => "#{debug_flag}"} )
    notifies :restart, resources(:service => 'rexster')
end


