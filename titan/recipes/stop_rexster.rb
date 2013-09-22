# Copyright 2013 ConnectDotz.com, LLC. All Rights Reserved.
#

#
# start rexster
#


execute "stop-rexster" do
command "cd #{node['titan']['rexster_home']} && bin/rexster.sh --stop"
end


