#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#
# initialize hadoop services under init.d
#
# hadoop init.d
template "/etc/init.d/hbase-master" do
  source "hbase-initd.erb"
  owner 'root' and mode 0755
  variables({
     :script_service => 'master',
  })
end

template "/etc/init.d/hbase-regionserver" do
  source "hbase-initd.erb"
  owner 'root' and mode 0755
  variables({
     :script_service => 'regionserver',
  })
end

template "/etc/init.d/zookeeper" do
  source "hbase-initd.erb"
  owner 'root' and mode 0755
  variables({
     :script_service => 'zookeeper',
  })
end

