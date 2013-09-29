# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

#
# start rexster
#

include_recipe "hadoop-services"

execute 'start-hadoop-namenode' do
    command 'echo "starting hadoop-namenode"'
    notifies :start, resources(:service => 'hadoop-namenode')
end

