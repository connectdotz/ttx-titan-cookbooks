#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#
# update attributes based on opswork context, this should only be called once at each configuration round 
#


#hadoop.fs_name : check namenode private_ip address 
ruby_block "update hadoop.fs_name" do 
	block do
	
		layer_name = node[:ttx_hbase][:opsworks][:hadoop_namenode_layer]
		layer = defined?(node[:opsworks][:layers][layer_name]) == nil ? nil : node[:opsworks][:layers][layer_name]

		if defined?(node[:opsworks][:layers]) != nil
			puts node[:opsworks][:layers].inspect
		else
			puts "no node[:opsworks][:layers]"
		end

		node.override[:ttx_hbase][:opsworks][:hadoop_fs_name_changed] = false
		instance = nil
	
		if layer != nil
			if layer[:instances].length != 1
			    #check if current instance belong to the layer
				if node[:opsworks][:instance][:layers].include?(layer_name)
					instance = node[:opsworks][:instance]
				end
			else
				layer[:instances].each do |key, value|
				    instance = value
					break
				end
			end

			if (instance != nil)
				new_name = "hdfs://#{instance[:private_ip]}:9000"
				if(new_name != node[:ttx_hbase][:hadoop][:_fs_name])
					node.override[:ttx_hbase][:hadoop][:_fs_name] = new_name
					Chef::Log.info("found updated namenode instance: #{instance.inspect}") 
					node.override[:ttx_hbase][:opsworks][:hadoop_fs_name_changed] = true
				end
			end
		end

		if(instance == nil)
			Chef::Log.debug("will use default namenode") 
		end

		Chef::Log.info( "fs_name_changed? #{node[:ttx_hbase][:opsworks][:hadoop_fs_name_changed]}, fs_name = #{node[:ttx_hbase][:hadoop][:_fs_name]}") 
		
	end
end


ruby_block "update hbase.rootdir" do 
	block do
		new_name = "#{node[:ttx_hbase][:hadoop][:_fs_name]}/hbase"
		if(new_name != node[:ttx_hbase][:hbase][:_root_dir])
			node.override[:ttx_hbase][:hbase][:_root_dir] = new_name
			node.override[:ttx_hbase][:opsworks][:hbase_rootdir_changed] = true

			Chef::Log.info("hbase rootdir changed: #{new_name}") 
		else
		end

		Chef::Log.info("rootdir_changed? #{node[:ttx_hbase][:opsworks][:hbase_rootdir_changed]}, rootdir = #{node[:ttx_hbase][:hbase][:_root_dir]}") 
	end
end

ruby_block "update zookeeper.quorum" do 
	block do
		layer_name = node[:ttx_hbase][:opsworks][:zookeeper_layer]
		layer = defined?(node[:opsworks][:layers][layer_name]) == nil ? nil : node[:opsworks][:layers][layer_name]

		node.override[:ttx_hbase][:opsworks][:zookeeper_quorum_changed] = false

		quorum = Set.new;

		if layer != nil

			if node[:opsworks][:instance][:layers].include?(layer_name)
				quorum << node[:opsworks][:instance][:private_dns_name]
			end
	
			layer[:instances].each do |key, value|
				quorum << value[:private_dns_name]
			end
		end

		sorted_quorum =  quorum.to_a.sort
		if(sorted_quorum.length > 0 && sorted_quorum !=  node[:ttx_hbase][:zookeeper][:quorum].sort)
				node.override[:ttx_hbase][:zookeeper][:quorum] = sorted_quorum
				Chef::Log.info( "quorum changed: #{sorted_quorum}" )
				node.override[:ttx_hbase][:opsworks][:zookeeper_quorum_changed] = true
		end

		Chef::Log.info("zookeeper_quorum_changed? #{node[:ttx_hbase][:opsworks][:zookeeper_quorum_changed]}, quorum= #{node[:ttx_hbase][:zookeeper][:quorum]}")
		
	end
end






