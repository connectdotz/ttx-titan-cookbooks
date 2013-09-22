# Copyright 2013 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not
# use this file except in compliance with the License. A copy of the License is
# located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied. See the License for the specific language governing permissions
# and limitations under the License.

# runtime env
default['titan']['titan_version'] = '0.3.2'
default['titan']['rexster_version'] = '2.3.0'
default['titan']['runtime_env'] = 'beta'
default['titan']['base_dir'] = '/opt/chef-test2'
default['titan']['rexster_path'] = 'rexster-server'
default['titan']['titan_path'] = 'titan'

# execution tuning
default['titan']['rexster_java_options'] = ''

# titan logging and debugging
default['titan']['log_dir'] = '/var/log/titan'
default['titan']['log_level'] = 'INFO'
default['titan']['debug'] = false 

# composite attributes
node.normal['titan']['rexster_home'] = "#{node['titan']['base_dir']}/#{node['titan']['rexster_path']}"
node.normal['titan']['titan_home'] = "#{node['titan']['base_dir']}/#{node['titan']['titan_path']}"

# es
default['titan']['es']['host_name'] = '127.0.0.1'