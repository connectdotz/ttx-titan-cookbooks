#
# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "ttx_hbase::hadoop-services"

ruby_block "format-and-start-namenode" do
	block do
		if (!File.exists?("#{node[:ttx_hbase][:hadoop][:name_dir]}/current/VERSION"))
			cmd = "echo 'N' | #{node[:ttx_hbase][:hadoop][:home]}/bin/hadoop namenode -format"
			%x( #{cmd} )
			Chef::Log.info( "namenode is formated" )
		end
	end
    notifies :enable, resources(:service => 'hadoop-namenode')
    notifies :restart, resources(:service => 'hadoop-namenode')
end


