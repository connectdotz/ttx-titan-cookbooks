#
# Copyright 2013 ConnectDotz, LLC
#

# OpsWorks env 
default[:ttx_hbase][:opsworks][:hadoop_namenode_layer] = 'hadoop-namenode'
default[:ttx_hbase][:opsworks][:hadoop_secondarynamenode_layer] = 'hadoop-secondarynamenode'
default[:ttx_hbase][:opsworks][:zookeeper_layer] = 'zookeeper'
default[:ttx_hbase][:opsworks][:hbase_master_layer] = 'hbase-master'
default[:ttx_hbase][:opsworks][:hbase_masters_backup_layer] = 'hbase-master-backup'

default[:ttx_hbase][:opsworks][:hadoop_fs_name_changed] = false
default[:ttx_hbase][:opsworks][:hbase_rootdir_changed] = false
default[:ttx_hbase][:opsworks][:zookeeper_quorum_changed] = false

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
default[:ttx_hbase][:hadoop][:tmp_dir] = '/var/hadoop/tmp'
default[:ttx_hbase][:hadoop][:pid_dir] = '/var/hadoop/pid'
default[:ttx_hbase][:hadoop][:log_dir] = '/var/log/hadoop'
default[:ttx_hbase][:hadoop][:hadoop_opts] = '-Djava.awt.headless=true'
default[:ttx_hbase][:hadoop][:replication] = 1
default[:ttx_hbase][:hadoop][:tracker] = 'localhost:9001'
default[:ttx_hbase][:hadoop][:user] = 'root'

default[:ttx_hbase][:hadoop][:fs_name] = nil
default[:ttx_hbase][:hadoop][:_fs_name] = 'hdfs://localhost:9000'

# hbase env
default[:ttx_hbase][:hbase][:home] = '/usr/local/hbase'
default[:ttx_hbase][:hbase][:conf] = "#{node[:ttx_hbase][:system][:config_root_dir]}/hbase"
default[:ttx_hbase][:hbase][:pid_dir] = '/var/hbase/pid'
default[:ttx_hbase][:hbase][:tmp_dir] = '/var/hbase/tmp'
default[:ttx_hbase][:hbase][:manage_zk] = true
default[:ttx_hbase][:hbase][:log_level] = 'INFO'
default[:ttx_hbase][:hbase][:log_dir] = '/var/log/hbase'
default[:ttx_hbase][:hbase][:user] = 'root'

default[:ttx_hbase][:hbase][:root_dir] = nil
default[:ttx_hbase][:hbase][:_root_dir] = "#{node[:ttx_hbase][:hadoop][:_fs_name]}/hbase"

#regionserver
default[:ttx_hbase][:regionserver][:handler_count] = 100

# zookeeper
default[:ttx_hbase][:zookeeper][:data_dir] = '/var/zookeeper/data'
default[:ttx_hbase][:zookeeper][:quorum] = ['localhost']

# execution tuning
