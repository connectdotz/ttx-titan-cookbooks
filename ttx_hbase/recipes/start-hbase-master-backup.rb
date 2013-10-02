#
# define rexster service
#

include_recipe "ttx_hbase::hbase-services"

execute "start-hbase-master-backup" do
	command "echo starting hbase master-backup..."
	notifies :enable, "service[hbase-master-backup]"
	notifies :restart, "service[hbase-master-backup]"
end

