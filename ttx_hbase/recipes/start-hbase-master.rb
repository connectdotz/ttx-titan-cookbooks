#
# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "ttx_hbase::hbase-services"

execute "start-hbase-master" do
	command "echo starting hbase master..."
	notifies :enable, "service[hbase-master]"
	notifies :restart, "service[hbase-master]"
end

