#
# define rexster service
#

include_recipe "ttx_hbase::hbase-services"

execute "start-hbase-regionserver" do
	command "echo starting hbase regionserver..."
	notifies :start, "service[hbase-regionserver]"
end

