#
# define rexster service
#

include_recipe "ttx_hbase::hbase-services"

execute "stop-zookeeper" do
	command "echo stopping zookeeper..."
	notifies :stop, "service[zookeeper]"
end

