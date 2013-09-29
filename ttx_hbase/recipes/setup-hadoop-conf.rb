#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#
# setup hadoop's configuration files
#

hadoop_home = "#{node[:ttx_hbase][:hadoop][:home]}"

# hadoop_env.sh 
template "hadoop-env-sh" do
  path "#{hadoop_home}/conf/hadoop-env.sh"
  source "hadoop-env-sh.erb"
  owner 'root' and mode 0644
  only_if { File.directory?( "#{hadoop_home}/conf" ) }
  action :create
end

# hdfs-site.xml 
template "hdfs-site-xml" do
  path "#{hadoop_home}/conf/hdfs-site.xml"
  source "hdfs-site-xml.erb"
  owner 'root' and mode 0644
  only_if { File.directory?( "#{hadoop_home}/conf" ) }
  action :create
end

# hadoop-core-site.xml 
template "hadoop-core-site-xml" do
  path "#{hadoop_home}/conf/core-site.xml"
  source "hadoop-core-site-xml.erb"
  owner 'root' and mode 0644
  only_if { File.directory?( "#{hadoop_home}/conf" ) }
  action :create
end

template "log4j-properties" do
  path "#{hadoop_home}/conf/log4j.properties"
  source "log4j-properties.erb"
  owner 'root' and mode 0644
  only_if { File.directory?( "#{hadoop_home}/conf" ) }
  action :create
end

log_dir="#{node[:ttx_hbase][:hadoop][:log_dir]}"

bash "set_hadoop_log" do
  user "root"
  code <<-EOH

	mkdir -p log_dir
	chmod 0655 log_dir
  EOH
end


