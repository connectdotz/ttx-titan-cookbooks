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
  action :nothing
end

# hdfs-site.xml 
template "hbase-site-xml" do
  path "#{hbase_home}/conf/hbase-site.xml"
  source "hbase-site-xml.erb"
  owner 'root' and mode 0644
  only_if { File.directory?( "#{hbase_home}/conf" ) }
  action :nothing
end

template "log4j-properties" do
  path "#{hbase_home}/conf/log4j.properties"
  source "log4j-properties.erb"
  owner 'root' and mode 0644
  only_if { File.directory?( "#{hbase_home}/conf" ) }
  action :nothing
end

log_dir="#{node[:ttx_hbase][:hbase][:log_dir]}"

bash "setup-hbase-conf" do
  user "root"
  code <<-EOH

	mkdir -p log_dir
	chmod 0655 log_dir

	## save original config files
	cd  #{hbase_home}/conf
	cp -n hbase-env.sh  hadoop-env.sh.orig
	cp -n hbase-site.xml core-site.xml.orig
	cp -n log4j.properties log4j.properties.orig

	echo "done"
  EOH

  notifies :create, "template[hbase-env-sh]", :immediately
  notifies :create, "template[hbase-site-xml]", :immediately
  notifies :create, "template[log4j-properties]", :immediately

  action :nothing

end

ruby_block "create-directories" do
	block do
	FileUtils.mkdir_p node[:ttx_hbase][:hbase][:tmp_dir]
	FileUtils.mkdir_p node[:ttx_hbase][:hbase][:pid_dir]
	FileUtils.mkdir_p node[:ttx_hbase][:zookeeper][:data_dir]
	end
end

