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
  action :nothing
end

# hdfs-site.xml 
template "hdfs-site-xml" do
  path "#{hadoop_home}/conf/hdfs-site.xml"
  source "hdfs-site-xml.erb"
  owner 'root' and mode 0644
  only_if { File.directory?( "#{hadoop_home}/conf" ) }
  action :nothing
end

# hadoop-core-site.xml 
template "hadoop-core-site-xml" do
  path "#{hadoop_home}/conf/core-site.xml"
  source "hadoop-core-site-xml.erb"
  owner 'root' and mode 0644
  only_if { File.directory?( "#{hadoop_home}/conf" ) }
  action :nothing
end

template "log4j-properties" do
  path "#{hadoop_home}/conf/log4j.properties"
  source "log4j-properties.erb"
  owner 'root' and mode 0644
  only_if { File.directory?( "#{hadoop_home}/conf" ) }
  action :nothing
end

log_dir="#{node[:ttx_hbase][:hadoop][:log_dir]}"

bash "setup-hadoop-conf" do
  user "root"
  code <<-EOH

	mkdir -p log_dir
	chmod 0655 log_dir

	## save original config files
	cd  #{hadoop_home}/conf
	cp -n hadoop-env.sh  hadoop-env.sh.orig
	cp -n core-site.xml core-site.xml.orig
	cp -n hdfs-site.xml hdfs-site.xml.orig
	cp -n log4j.properties log4j.properties.orig
	
	echo "done"
    
  EOH

  notifies :create, "template[hadoop-env-sh]", :immediately
  notifies :create, "template[hdfs-site-xml]", :immediately
  notifies :create, "template[hadoop-core-site-xml]", :immediately
  notifies :create, "template[log4j-properties]", :immediately

  action :nothing
end

ruby_block "create-directories" do
    block do
	FileUtils.mkdir_p node[:ttx_hbase][:hadoop][:tmp_dir]
	FileUtils.mkdir_p node[:ttx_hbase][:hadoop][:pid_dir]

	FileUtils.mkdir_p node[:ttx_hbase][:hadoop][:data_dir]

	end
end


