#
# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "ttx_hbase::hadoop-services"

execute 'start-hadoop-secondarynamenode' do
    command 'echo "starting hadoop-secondarynamenode"'
    notifies :enable, resources(:service => 'hadoop-secondarynamenode')
    notifies :restart, resources(:service => 'hadoop-secondarynamenode')
end

