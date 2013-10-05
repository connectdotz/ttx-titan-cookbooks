#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#
# update attributes based on opswork context, this should only be called once at each configuration round 
#


#hadoop.fs_name : check namenode private_ip address 
ruby_block "update es.host_name" do 
	block do
	
		layer_name = node[:titan][:opsworks][:es_layer]
		layer = defined?(node[:opsworks][:layers][layer_name]) == nil ? nil : node[:opsworks][:layers][layer_name]

		if defined?(node[:opsworks][:layers]) != nil
			puts node[:opsworks][:layers].inspect
		else
			puts "no node[:opsworks][:layers]"
		end

		node.override[:titan][:opsworks][:es_hostname_changed] = false
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
				new_name = instance[:private_ip]
				if(new_name != node[:titan][:es][:host_name])
					node.override[:titan][:es][:host_name] = new_name
					Chef::Log.info("found updated es instance: #{instance.inspect}") 
					node.override[:titan][:opsworks][:es_hostname_changed] = true
				end
			end
		end

		if(instance == nil)
			Chef::Log.debug("will use default es.host_name") 
		end

		Chef::Log.info( "es_hostname_changed? #{node[:titan][:opsworks][:es_hostname_changed]}, host_name = #{node[:titan][:es][:host_name]}") 
		
	end
end


