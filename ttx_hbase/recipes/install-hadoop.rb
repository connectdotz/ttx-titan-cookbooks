#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#
# initialize hadoop services under init.d
#
# hadoop init.d
template "/etc/init.d/hadoop_namenode" do
  source "hadoop_namenode_initd.erb"
  owner 'root' and mode 0755
end

template "/etc/init.d/hadoop_datanode" do
  source "hadoop_datanode_initd.erb"
  owner 'root' and mode 0755
end

template "/etc/init.d/hadoop_namenode_2nd" do
  source "hadoop_namenode_2nd_initd.erb"
  owner 'root' and mode 0755
end

# rexster config
template "rexster_xml" do
  path "#{hadoop_home}/rexster.xml"
  source "rexster_xml.erb"
  owner 'root' and mode 0644
  action :nothing
end

template "log4j_properties" do
  path "#{hadoop_home}/log4j.properties"
  source "log4j_properties.erb"
  owner 'root' and mode 0644
  action :nothing
end

log_dir="#{node[:ttx_hbase]['log_dir']}"
base_dir="#{node[:ttx_hbase]['base_dir']}"

bash "install_titan" do
  user "root"
  code <<-EOH

    echo "base_dir=#{base_dir}"
    echo "log_dir=#{log_dir}"
    echo "hadoop_home=#{hadoop_home}"
    echo "titan_home=#{titan_home}"

    #install ttx home  directory
    mkdir -p #{base_dir}
    cd #{base_dir}

    ###### download titan components #####
    echo "installing #{node[:ttx_hbase]['rexster_path']} ..."
    zip_file="rexster-server-#{node[:ttx_hbase]['rexster_version']}"
    if [ ! -d "#{node[:ttx_hbase]['rexster_path']}" ]; then
        curl -# -L -k "http://tinkerpop.com/downloads/rexster/$zip_file.zip" > $zip_file.zip
        unzip $zip_file.zip 
        ln -s $zip_file #{node[:ttx_hbase]['rexster_path']}
        rm $zip_file.zip
    else
        echo "directory existed, skipped"
    fi

    echo "installing rexster-console ..."
    zip_file2="rexster-console-#{node[:ttx_hbase]['rexster_version']}"
    if [ ! -d "rexster-console" ]; then
    	curl -# -L -k "http://tinkerpop.com/downloads/rexster/$zip_file2.zip" > $zip_file2.zip
    	unzip $zip_file2.zip 
    	ln -s $zip_file2 rexster-console
    	rm $zip_file2.zip
    else
        echo "directory existed, skipped"
    fi

    echo "installing titan-hbase ..."
    zip_file3="titan-hbase-#{node[:ttx_hbase]['titan_version']}"
    if [ ! -d "#{node[:ttx_hbase]['titan_path']}" ]; then
    	curl -# -L -k "http://s3.thinkaurelius.com/downloads/titan/$zip_file3.zip" > $zip_file3.zip
    	unzip $zip_file3.zip 
    	ln -s $zip_file3 #{node[:ttx_hbase]['titan_path']}
    	rm $zip_file3.zip
    else
        echo "directory existed, skipped"
    fi

    #install titan with rexster
    ln -s #{titan_home}/lib #{hadoop_home}/ext/titan
    
    #fix rexster/titan lucent library conflict
    mkdir #{hadoop_home}/titan_conflict
    mv #{hadoop_home}/lib/lucene* #{hadoop_home}/titan_conflict
    
    #tar -xvopf /tmp/ttx-titan-dist.tar.gz
    #rm -rf /tmp/ttx-titan-dist.tar.gz

    ####### initialize log directory
    mkdir -p #{log_dir}
    chmod og+r #{log_dir}
  EOH
  # notifies :run, "bash[setup_rexster_titan]", :immediately
  notifies :create, "template[rexster_xml]", :immediately
  notifies :create, "template[log4j_properties]", :immediately
end

