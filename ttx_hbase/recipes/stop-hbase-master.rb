#
# define rexster service
#

include_recipe "ttx_hbase::hbase-services"

execute "start-zookeeper" do
	command "echo starting zookeeper..."
	notifies :start, "service[zookeeper]"
end

