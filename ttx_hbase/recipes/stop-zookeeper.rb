#
# define rexster service
#

include_recipe "hbase-services"

execute "stop-zookeeper" do
	command "echo stopping zookeeper..."
	notifies :stop, "service[zookeeper]"
end

