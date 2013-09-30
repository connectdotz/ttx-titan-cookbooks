#
# define rexster service
#

include_recipe "ttx_hbase::hbase-services"

execute "stop-hbase-regionserver" do
	command "echo stopping hbase regionserver..."
	notifies :stop, "service[hbase-regionserver]"
end

