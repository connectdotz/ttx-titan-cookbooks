#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#
# triggered by the OpsWork configuration lifecycle event when any instance came online in the stack
#

include_recipe 'ttx_hbase::opsworks-context'
include_recipe 'ttx_hbase::setup-hadoop-conf'
include_recipe 'ttx_hbase::hadoop-services'

execute "restart-hadoop-datanode" do
	command "echo perform configure operation"
	only_if { node[:ttx_hbase][:opsworks][:hadoop_fs_name_changed] == true}
	notifies :run, "bash[setup-hadoop-conf]", :immediately
	notifies :restart, "service[hadoop-datanode]", :delayed
end


