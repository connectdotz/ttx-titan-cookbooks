#
# Copyright 2013 ConnectDotz, LLC. All Rights Reserved.
#


rexster_home = "#{node['titan']['rexster_home']}"
titan_home = "#{node['titan']['titan_home']}"

# rexster config
template "rexster_xml" do
  path "#{rexster_home}/rexster.xml"
  source "rexster_xml.erb"
  owner 'root' and mode 0644
  action :nothing
end

template "log4j_properties" do
  path "#{rexster_home}/log4j.properties"
  source "log4j_properties.erb"
  owner 'root' and mode 0644
  action :nothing
end

