#
# define rexster service
#

include_recipe "hbase-services"

execute "stop-hbase-regionserver" do
	command "echo stopping hbase regionserver..."
	notifies :stop, "service[hbase-regionserver]"
end

