#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#include_recipe 'install_hadoop'
include_recipe 'ttx_hbase::setup-hadoop-initd'

include_recipe 'ttx_hbase::opswork-context'
include_recipe 'ttx_hbase::setup-hadoop-conf'

execute "setup-hadoop" do
	command "echo setup-hadoop"
	notifies :run, "bash[setup-hadoop-conf]", :immediately
end

