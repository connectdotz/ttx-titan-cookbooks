#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#
# initialize hbase services under init.d
#
# hbase init.d
#
template "/etc/init.d/hbase-master" do
  source "hbase-initd.erb"
  owner 'root' and mode 0755
  variables({
     :script_service => 'master',
     :script_args => ''
  })
end

template "/etc/init.d/hbase-master-backup" do
  source "hbase-initd.erb"
  owner 'root' and mode 0755
  variables({
     :script_service => 'master-backup',
     :script_args => '--backup'
  })
end

template "/etc/init.d/hbase-regionserver" do
  source "hbase-initd.erb"
  owner 'root' and mode 0755
  variables({
     :script_service => 'regionserver',
     :script_args => ''
  })
end

template "/etc/init.d/zookeeper" do
  source "hbase-initd.erb"
  owner 'root' and mode 0755
  variables({
     :script_service => 'zookeeper',
     :script_args => ''
  })
end

