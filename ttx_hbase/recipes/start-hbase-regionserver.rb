#
# define rexster service
#

include_recipe "ttx_hbase::hbase-services"

execute "start-hbase-regionserver" do
	command "echo starting hbase regionserver..."
	notifies :enable, "service[hbase-regionserver]"
	notifies :restart, "service[hbase-regionserver]"
end

