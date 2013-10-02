# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

#
# start rexster
#

include_recipe "ttx_hbase::hadoop-services"

execute 'start-hadoop-datanode' do
    command 'echo "starting hadoop-datanode"'
    notifies :enable, resources(:service => 'hadoop-datanode')
    notifies :restart, resources(:service => 'hadoop-datanode')
end

