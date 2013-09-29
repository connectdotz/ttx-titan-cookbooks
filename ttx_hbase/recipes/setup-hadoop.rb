#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#

#include_recipe 'install_hadoop'
include_recipe 'setup-hadoop-initd'
include_recipe 'setup-hadoop-conf'


