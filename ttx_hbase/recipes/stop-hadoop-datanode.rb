# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "ttx_hbase::hadoop-services"

execute 'stop-hadoop-datanode' do
    command 'echo "stopping hadoop-datanode"'
    notifies :stop, resources(:service => 'hadoop-datanode')
end

