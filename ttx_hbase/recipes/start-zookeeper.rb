#
# define rexster service
#

include_recipe "hbase-services"

execute "start-zookeeper" do
	command "echo starting zookeeper..."
	notifies :start, "service[zookeeper]"
end

