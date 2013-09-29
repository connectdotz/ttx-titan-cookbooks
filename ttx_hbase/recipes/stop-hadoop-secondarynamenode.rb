# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

include_recipe "hadoop-secondarynamenode"

execute 'stop-hadoop-secondarynamenode' do
    command 'echo "stopping hadoop-secondarynamenode"'
    notifies :stop, resources(:service => 'hadoop-secondarynamenode')
end

