# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

#
# start rexster
#

debug_flag = ( node['titan']['debug'] == true ? "-d" : "" )
output = "#{node['titan']['log_dir']}/rexster.out" 

execute "start-rexster" do
command "cd #{node['titan']['rexster_home']} && nohup bin/rexster.sh --start \"#{debug_flag}\" > \"#{output}\" 2>&1 &"
environment ({ "JAVA_OPTIONS" => "#{node['titan']['rexster_java_options']}"} )
end


