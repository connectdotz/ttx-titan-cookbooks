#
# define rexster service
#

include_recipe "hbase-services"

execute "start-hbase-master" do
	command "echo starting hbase master..."
	notifies :start, "service[hbase-master]"
end

