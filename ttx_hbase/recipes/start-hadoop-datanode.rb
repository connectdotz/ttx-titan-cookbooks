# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

#
# start rexster
#

include_recipe "hadoop-services"

execute 'start-hadoop-datanode' do
    command 'echo "starting hadoop-datanode"'
    notifies :start, resources(:service => 'hadoop-datanode')
end

