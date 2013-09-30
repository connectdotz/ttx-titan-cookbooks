#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#include_recipe 'install-hbase'

include_recipe 'ttx_hbase::setup-hbase-initd'

include_recipe 'ttx_hbase::opswork-context'
include_recipe 'ttx_hbase::setup-hbase-conf'

execute "setup-hbase" do
	command "echo setup-hbase"
	notifies :run, "bash[setup-hbase-conf]", :immediately
end


