#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#
# update attributes based on opswork context, this should only be called once at each configuration round 
#


#hadoop.fs_name : check namenode private_ip address 
ruby_block "update hadoop.fs_name" do 
	block do
		layer = node[:ttx_hbase][:opsworks][:hadoop_namenode_layer]
		namenode = defined?(node[:opsworks][:layers][layer]) == nil ? nil : node[:opsworks][:layers][layer]

		if defined?(node[:opsworks][:layers]) != nil
			puts node[:opsworks][:layers]
		else
			puts "no node[:opsworks][:layers]"
		end

		node.override[:ttx_hbase][:opsworks][:hadoop_fs_name_changed] = false
	
		if namenode != nil
			if namenode[:instances].length != 1
				Chef::Log.error("will use default namenode because namenode instances count is #{namenode[:instances].length}") 
			else
				namenode[:instances].each do |instance|
					new_name = "hdfs://#{instance[:private_ip]}:9000"

					if(new_name != node[:ttx_hbase][:hadoop][:fs_name])
						node.override[:ttx_hbase][:hadoop][:fs_name] = new_name
						Chef::Log.info("found namenode from opsworks namenode layer '#{layer}': dns:#{instance[:public_dns_name]}, availability_zone:#{instance[:availability_zone]}, aws_instance_id: #{instance[:aws_instance_id]}") 
						node.override[:ttx_hbase][:opsworks][:hadoop_fs_name_changed] = true
					end
				end
			end
		else
			Chef::Log.debug("will use default namenode because no namenode layer '#{layer}' is found") 
		end

		Chef::Log.info( "fs_name_changed? #{node[:ttx_hbase][:opsworks][:hadoop_fs_name_changed]}, fs_name = #{node[:ttx_hbase][:hadoop][:fs_name]}") 
		
	end
end


ruby_block "update hbase.rootdir" do 
	block do
		layer_name = node[:ttx_hbase][:opsworks][:hbase_master_layer]
		layer = defined?(node[:opsworks][:layers][layer_name]) == nil ? nil : node[:opsworks][:layers][layer_name]
	

		node.override[:ttx_hbase][:opsworks][:hbase_rootdir_changed] = false
	
		if layer != nil
			if layer[:instances].length != 1
				Chef::Log.error("will use default root_dir because hbase-master instances count is #{layer[:instances].length}") 
			else
				layer[:instances].each do |instance|
					new_name = "hdfs://#{instance[:private_ip]}:9000"

					if(new_name != node[:ttx_hbase][:hadoop][:root_dir])
						node.override[:ttx_hbase][:hadoop][:root_dir] = new_name
						Chef::Log.info("found hbase-master from opsworks layer '#{layer}': dns:#{instance[:public_dns_name]}, availability_zone:#{instance[:availability_zone]}, aws_instance_id: #{instance[:aws_instance_id]}") 
						node.override[:ttx_hbase][:opsworks][:hbase_rootdir_changed] = true
					end
				end
			end
		else
			Chef::Log.debug("will use default rootdir because no layer '#{layer}' is found")
		end

		Chef::Log.info("rootdir_changed? #{node[:ttx_hbase][:opsworks][:hbase_rootdir_changed]}, rootdir = #{node[:ttx_hbase][:hbase][:root_dir]}") 
		
	end
end

ruby_block "update zookeeper.quorum" do 
	block do
		layer_name = node[:ttx_hbase][:opsworks][:zookeeper_layer]
		layer = defined?(node[:opsworks][:layers][layer_name]) == nil ? nil : node[:opsworks][:layers][layer_name]

		node.override[:ttx_hbase][:opsworks][:zookeeper_quorum_changed] = false
	
		if layer != nil

			quorum = Array.new;
			layer[:instances].each do |instance|
				quorum << "#{instance[:private_dns_name]}"
			end

			if(quorum.sort !=  node[:ttx_hbase][:zookeeper][:quorum].sort)
					node.override[:ttx_hbase][:zookeeper][:quorum] = quorum
					Chef::Log.info( "quorum changed: #{quorum}" )
					node.override[:ttx_hbase][:opsworks][:zookeeper_quorum_changed] = true
			end
		else
			Chef::Log.debug( "will use default rootdir because no layer '#{layer}' is found" )
		end

		Chef::Log.info("zookeeper_quorum_changed? #{node[:ttx_hbase][:opsworks][:zookeeper_quorum_changed]}, quorum= #{node[:ttx_hbase][:zookeeper][:quorum]}")
		
	end
end






