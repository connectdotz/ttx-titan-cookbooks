#
# Copyright 2013 ConnectDotz, LLC
#

# system env
default[:ttx_hbase][:system][:config_root_dir] = '/etc'
default[:ttx_hbase][:system][:package_root_dir] = '/opt'

# java env
default[:ttx_hbase][:java][:home] = ENV['JAVA_HOME'] || '/usr/java/jdk1.7.0'

# hadoop env
default[:ttx_hbase][:hadoop][:home] = '/usr/local/hadoop'
default[:ttx_hbase][:hadoop][:conf] = "#{node[:ttx_hbase][:system][:config_root_dir]}/hadoop"
default[:ttx_hbase][:hadoop][:name_dir] = '/var/hadoop/dfs/name'
default[:ttx_hbase][:hadoop][:data_dir] = '/var/hadoop/dfs/data'
default[:ttx_hbase][:hadoop][:pid_dir] = '/var/hadoop/pid'
default[:ttx_hbase][:hadoop][:log_dir] = '/var/log/hadoop'
default[:ttx_hbase][:hadoop][:fs_name] = 'hdfs://localhost:9000'
default[:ttx_hbase][:hadoop][:hadoop_opts] = '-Djava.awt.headless=true'
default[:ttx_hbase][:hadoop][:replication] = 1
default[:ttx_hbase][:hadoop][:tracker] = 'localhost:9001'

# hbase env
default[:ttx_hbase][:hbase][:home] = '/usr/local/hbase'
default[:ttx_hbase][:hbase][:conf] = "#{node[:ttx_hbase][:system][:config_root_dir]}/hbase"
default[:ttx_hbase][:hbase][:rootdir] = 'hdfs://localhost:9000/hbase'
default[:ttx_hbase][:hbase][:pid_dir] = '/var/hbase/pid'
default[:ttx_hbase][:hbase][:manage_zk] = true
default[:ttx_hbase][:hbase][:log_level] = 'INFO'
default[:ttx_hbase][:hbase][:log_dir] = '/var/log/hbase'

# zookeeper
default[:ttx_hbase][:zookeeper][:data_dir] = 'var/zookeeper/data'
default[:ttx_hbase][:zookeeper][:quorum] = 'localhost'

# execution tuning
