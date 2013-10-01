#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#
# triggered by the OpsWork configuration lifecycle event when any instance came online in the stack
#

include_recipe 'ttx_hbase::opswork-context'
include_recipe 'ttx_hbase::setup-hbase-conf'
include_recipe 'ttx_hbase::hbase_services'

execute "restart-hbase-master" do
	command "echo perform configure operation"
	only_if { node[:ttx_hbase][:opsworks][:hadoop_fs_name_changed] || node[:ttx_hbase][:opsworks][:zookeeper_quorum_changed] }
	notifies :run, "bash[setup-hbase-conf]", :immediately
	notifies :reload, "service[hbase-master]", :delayed
end

