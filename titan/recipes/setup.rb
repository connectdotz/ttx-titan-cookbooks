#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#cookbook_file "/tmp/ttx-titan-dist.tar.gz" do
#  source "ttx-titan-dist.tar.gz"
#end

include_recipe 'titan::opsworks-context'
include_recipe 'titan::setup-config'

rexster_home = "#{node['titan']['rexster_home']}"
titan_home = "#{node['titan']['titan_home']}"
log_dir="#{node['titan']['log_dir']}"
base_dir="#{node['titan']['base_dir']}"

bash "install_titan" do
  user "root"
  code <<-EOH

    echo "base_dir=#{base_dir}"
    echo "log_dir=#{log_dir}"
    echo "rexster_home=#{rexster_home}"
    echo "titan_home=#{titan_home}"

    #install ttx home  directory
    mkdir -p #{base_dir}
    cd #{base_dir}

    ###### download titan components #####
    echo "installing #{node['titan']['rexster_path']} ..."
    zip_file="rexster-server-#{node['titan']['rexster_version']}"
    if [ ! -d "#{node['titan']['rexster_path']}" ]; then
        curl -# -L -k "http://tinkerpop.com/downloads/rexster/$zip_file.zip" > $zip_file.zip
        unzip $zip_file.zip 
        ln -s $zip_file #{node['titan']['rexster_path']}
        rm $zip_file.zip
    else
        echo "directory existed, skipped"
    fi

    echo "installing rexster-console ..."
    zip_file2="rexster-console-#{node['titan']['rexster_version']}"
    if [ ! -d "rexster-console" ]; then
    	curl -# -L -k "http://tinkerpop.com/downloads/rexster/$zip_file2.zip" > $zip_file2.zip
    	unzip $zip_file2.zip 
    	ln -s $zip_file2 rexster-console
    	rm $zip_file2.zip
    else
        echo "directory existed, skipped"
    fi

    echo "installing titan-hbase ..."
    zip_file3="titan-hbase-#{node['titan']['titan_version']}"
    if [ ! -d "#{node['titan']['titan_path']}" ]; then
    	curl -# -L -k "http://s3.thinkaurelius.com/downloads/titan/$zip_file3.zip" > $zip_file3.zip
    	unzip $zip_file3.zip 
    	ln -s $zip_file3 #{node['titan']['titan_path']}
    	rm $zip_file3.zip
    else
        echo "directory existed, skipped"
    fi

    #install titan with rexster
    ln -s #{titan_home}/lib #{rexster_home}/ext/titan
    
    #fix rexster/titan lucent library conflict
    mkdir #{rexster_home}/titan_conflict
    mv #{rexster_home}/lib/lucene* #{rexster_home}/titan_conflict
    
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

template "/etc/init.d/rexster" do
  source "rexster_service_init.erb"
  owner 'root' and mode 0755
end


