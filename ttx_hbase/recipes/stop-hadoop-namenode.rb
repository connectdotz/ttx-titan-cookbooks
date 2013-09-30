# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "ttx_hbase::hadoop-services"

execute 'stop-hadoop-namenode' do
    command 'echo "stopping hadoop-namenode"'
    notifies :stop, resources(:service => 'hadoop-namenode')
end

