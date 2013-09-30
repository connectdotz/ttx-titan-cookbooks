# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "ttx_hbase::hadoop-services"

execute 'stop-hadoop-secondarynamenode' do
    command 'echo "stopping hadoop-secondarynamenode"'
    notifies :stop, resources(:service => 'hadoop-secondarynamenode')
end

