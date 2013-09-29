#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#
# setup hbase's configuration files
#

hbase_home = "#{node[:ttx_hbase][:hbase][:home]}"

# hbase_env.sh 
template "hbase-env-sh" do
  path "#{hbase_home}/conf/hbase-env.sh"
  source "hbase-env-sh.erb"
  owner 'root' and mode 0644
  only_if { File.directory?( "#{hbase_home}/conf" ) }
  action :create
end

# hdfs-site.xml 
template "hbase-site-xml" do
  path "#{hbase_home}/conf/hbase-site.xml"
  source "hbase-site-xml.erb"
  owner 'root' and mode 0644
  only_if { File.directory?( "#{hbase_home}/conf" ) }
  action :create
end

# hbase-core-site.xml 
template "hbase-core-site-xml" do
  path "#{hbase_home}/conf/core-site.xml"
  source "hbase-core-site-xml.erb"
  owner 'root' and mode 0644
  only_if { File.directory?( "#{hbase_home}/conf" ) }
  action :create
end

template "log4j-properties" do
  path "#{hbase_home}/conf/log4j.properties"
  source "log4j-properties.erb"
  owner 'root' and mode 0644
  only_if { File.directory?( "#{hbase_home}/conf" ) }
  action :create
end

log_dir="#{node[:ttx_hbase][:hbase][:log_dir]}"

bash "set_hbase_log" do
  user "root"
  code <<-EOH

	mkdir -p log_dir
	chmod 0655 log_dir
  EOH
end


