#
# define rexster service
#

template "/etc/init.d/rexster" do
  source "rexster_service_init.erb"
  owner 'root' and mode 0755
end

service "rexster" do
  supports :status => true, :start => true, :stop => true
  action :nothing
end
