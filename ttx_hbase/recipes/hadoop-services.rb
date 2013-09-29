#
# define rexster service
#


service "hadoop-namenode" do
  supports :reload => true, :start => true, :stop => true
  action :nothing
end

service "hadoop-datanode" do
  supports :reload => true, :start => true, :stop => true
  action :nothing
end

service "hadoop-secondarynamenode" do
  supports :reload => true, :start => true, :stop => true
  action :nothing
end

