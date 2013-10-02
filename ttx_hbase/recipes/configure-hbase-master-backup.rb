#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#
# triggered by the OpsWork configuration lifecycle event when any instance came online in the stack
#

include_recipe 'ttx_hbase::opsworks-context'
include_recipe 'ttx_hbase::setup-hbase-conf'
include_recipe 'ttx_hbase::hbase-services'

execute "restart-hbase-master-backup" do
	command "echo perform configure operation"
	only_if { node[:ttx_hbase][:opsworks][:hadoop_fs_name_changed] || 
		node[:ttx_hbase][:opsworks][:zookeeper_quorum_changed] }
	notifies :run, "bash[setup-hbase-conf]", :immediately
	notifies :restart, "service[hbase-master-backup]", :delayed
end


