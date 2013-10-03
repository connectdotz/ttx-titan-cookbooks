#
# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "ttx_hbase::hbase-services"

execute "start-zookeeper" do
	command "echo starting zookeeper..."
	notifies :enable, "service[zookeeper]"
	notifies :restart, "service[zookeeper]"
end

