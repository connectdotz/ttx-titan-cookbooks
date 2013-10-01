#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#


include_recipe 'ttx_hbase::setup-hadoop-initd'

include_recipe 'ttx_hbase::opsworks-context'
include_recipe 'ttx_hbase::setup-hadoop-conf'

cookbook_file "/tmp/install-hbase.sh" do
	source "install-hbase.sh"
	owner "root"
	group "root"
	mode 0555
	backup false

    #notifies :run, "execute[setup-hadoop]", :immediately
end

execute "install-hadoop" do
	command "/tmp/install-hbase.sh"
	#action :nothing

#	notifies :run, "bash[setup-hadoop]", :immediately
	notifies :run, "bash[setup-hadoop-conf]", :immediately
end

