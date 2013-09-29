#
# define rexster service
#


service "hbase-master" do
  supports :reload => true, :start => true, :stop => true
  action :nothing
end

service "hbase-regionserver" do
  supports :reload => true, :start => true, :stop => true
  action :nothing
end

service "hbase-master-backup" do
  supports :reload => true, :start => true, :stop => true
  action :nothing
end

service "zookeeper" do
  supports :reload => true, :start => true, :stop => true
  action :nothing
end

bash "start-hbase" do
	command "echo starting hbase dfs services..."

	notifies :start, "service[zookpper]"
	notifies :start, "service[hbase-master]"
	notifies :start, "service[hbase-regionserver]"
	notifies :start, "service[hbase-master-backup]"

	action :nothing
end

bash "stop-hbase" do
	command "echo starting hbase dfs services..."

	notifies :stop, "service[zookpper]"
	notifies :stop, "service[hbase-master]"
	notifies :stop, "service[hbase-regionserver]"

	action :nothing
end
