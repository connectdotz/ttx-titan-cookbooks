#
# define rexster service
#

include_recipe "hbase-services"

execute "stop-hbase-master-backup" do
	command "echo stopping hbase master-backup..."
	notifies :stop, "service[hbase-master-backup]"
end

