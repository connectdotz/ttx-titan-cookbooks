#
# define rexster service
#

include_recipe "hbase-services"

execute "start-hbase-master-backup" do
	command "echo starting hbase master-backup..."
	notifies :start, "service[hbase-master-backup]"
end

