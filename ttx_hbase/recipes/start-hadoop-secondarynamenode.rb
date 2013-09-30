# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

#
# start rexster
#

include_recipe "ttx_hbase::hadoop-services"

execute 'start-hadoop-secondarynamenode' do
    command 'echo "starting hadoop-secondarynamenode"'
    notifies :start, resources(:service => 'hadoop-secondarynamenode')
end

