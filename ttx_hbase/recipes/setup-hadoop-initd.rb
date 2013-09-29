#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#
# initialize hadoop services under init.d
#
# hadoop init.d
template "/etc/init.d/hadoop-namenode" do
  source "hadoop-initd.erb"
  owner 'root' and mode 0755
  variables({
     :script_service => 'namenode',
  })
end

template "/etc/init.d/hadoop-datanode" do
  source "hadoop-initd.erb"
  owner 'root' and mode 0755
  variables({
     :script_service => 'datanode',
  })
end

template "/etc/init.d/hadoop-secondarynamenode" do
  source "hadoop-initd.erb"
  owner 'root' and mode 0755
  variables({
     :script_service => 'secondarynamenode',
  })
end

