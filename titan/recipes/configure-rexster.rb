#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#
# triggered by the OpsWork configuration lifecycle event when any instance came online in the stack
#

include_recipe 'titan::opsworks-context'
include_recipe 'titan::setup-config'
include_recipe 'titan::rexster-service'

execute "restart-rexster" do
	command "echo perform configure operation"
	only_if { node[:titan][:opsworks][:es_hostname_changed] == true}

	notifies :create, "template[rexster_xml]", :immediately
	notifies :restart, "service[rexster]", :delayed
end


