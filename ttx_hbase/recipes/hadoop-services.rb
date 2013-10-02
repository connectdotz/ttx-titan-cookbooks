#
# define rexster service
#


service "hadoop-namenode" do
  supports :restart => true, :start => true, :stop => true, :status => true
  action :nothing
end

service "hadoop-datanode" do
  supports :restart => true, :start => true, :stop => true, :status => true
  action :nothing
end

service "hadoop-secondarynamenode" do
  supports :restart => true, :start => true, :stop => true, :status => true
  action :nothing
end

