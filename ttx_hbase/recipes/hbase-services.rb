#
# define rexster service
#


service "hbase-master" do
  supports :restart => true, :start => true, :stop => true, :status => true
  action :nothing
end

service "hbase-regionserver" do
  supports :restart => true, :start => true, :stop => true, :status => true
  action :nothing
end

service "hbase-master-backup" do
  supports :restart => true, :start => true, :stop => true, :status => true
  action :nothing
end

service "zookeeper" do
  supports :restart => true, :start => true, :stop => true, :status => true
  action :nothing
end

