#
# define rexster service
#


service "rexster" do
  supports :status => true, :start => true, :stop => true
  action :nothing
end
