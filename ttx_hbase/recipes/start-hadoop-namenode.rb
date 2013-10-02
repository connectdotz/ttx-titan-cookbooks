# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

#
# start rexster
#

include_recipe "ttx_hbase::hadoop-services"

ruby_block "format-namenode" do
	block do
		if (!File.exists?("#{node[:ttx_hbase][:hadoop][:name_dir]}/current/VERSION"))
			cmd = "echo 'N' | #{node[:ttx_hbase][:hadoop][:home]}/bin/hadoop namenode -format"
			%x( #{cmd} )
			Chef::Log.info( "namenode is formated" )
		end
	end
	notifies :run, "execute[start-hadoop-namenode]", :immediately
end

execute 'start-hadoop-namenode' do
    command 'echo "starting hadoop-namenode"'
	action :nothing
    notifies :enable, resources(:service => 'hadoop-namenode')
    notifies :start, resources(:service => 'hadoop-namenode')
end

