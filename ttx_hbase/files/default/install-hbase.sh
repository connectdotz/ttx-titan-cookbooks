#!/bin/bash

#
# install hbase and hadoop
#

####### variables
PKG_REPOSITORY_ROOT=/opt
SYSTEM_PKG_ROOT=/usr/local
SYSTEM_BIN_ROOT=/usr/bin
SYSTEM_CONF_ROOT=/etc

function install_tar_pkg {

    logical_name=$1
    url=$2

    echo "installing $logical_name from $url"

    #url=http://apache.cs.utah.edu/hadoop/common/stable/hadoop-1.2.1.tar.gz 
    file=`echo $url | sed "s/.*\///g"`
    PKG_NAME=`echo $file| sed "s/\.tar\.gz//"`

    if [ ! -d $PKG_REPOSITORY_ROOT/$PKG_NAME ];
    then
    	cd $PKG_REPOSITORY_ROOT
    	wget $url
    	tar -oxvpzf $file

    	rm $file
    	echo "$PKG_NAME installed"
    else
	echo "skip downloading $PKG_NAME"
    fi

    pkg_home=$SYSTEM_PKG_ROOT/$logical_name

    rm -f $pkg_home
    ln -s $PKG_REPOSITORY_ROOT/$PKG_NAME $pkg_home
    echo "setup $pkg_home"

    # setup conf
    if [ -d $pkg_home/conf -a ! -f $SYSTEM_CONF_ROOT/$logical_name ]; then
    	ln -s $pkg_home/conf $SYSTEM_CONF_ROOT/$logical_name
    	echo "setup $SYSTEM_CONF_ROOT/$logical_name"
    else
	echo "skip $SYSTEM_CONF_ROOT/$logical_name"
    fi 

    # setup the most important bin, if exist
    if [ -f $pkg_home/bin/$logical_name -a ! -f $SYSTEM_BIN_ROOT/$logical_name ]; then
    	ln -s $pkg_home/bin/$logical_name $SYSTEM_BIN_ROOT/$logical_name
    	echo "setup $SYSTEM_BIN_ROOT/$logical_name"
    else
	echo "skip $SYSTEM_BIN_ROOT/$logical_name"
    fi 
}

function config_system_hadoop {
    HADOOP_USER="root"
    echo "Configuring system for hadoop"

    has_hadoop=`grep "#hadoop" /etc/security/limits.conf`
    if [ "$has_hadoop" == "" ];
    then

        sudo chmod o+w /etc/security/limits.conf
        sudo echo "#hadoop" >> /etc/security/limits.conf
        sudo echo "$HADOOP_USER soft nofile 65536" >> /etc/security/limits.conf
        sudo echo "$HADOOP_USER hard nofile 65536" >> /etc/security/limits.conf
        sudo echo "$HADOOP_USER soft nproc 65536" >> /etc/security/limits.conf
        sudo echo "$HADOOP_USER hard nproc 65536" >> /etc/security/limits.conf
        sudo chmod o-w /etc/security/limits.conf

    else
        echo "already configured /etc/security/limits.conf"
    fi

    has_hadoop=`grep "#hadoop" /etc/sysctl.conf`

    if [ "$has_hadoop" == "" ];
    then
        sudo chmod o+w /etc/sysctl.conf
        sudo echo "#hadoop" >> /etc/sysctl.conf
        sudo echo "fs.file-max = 65536" >> /etc/sysctl.conf
        sudo echo "vm.swappiness = 0" >> /etc/sysctl.conf
        sudo chmod o-w /etc/sysctl.conf
    else
        echo "already configured /etc/sysctl.conf"
    fi

    echo "system is setup for hadoop use"
}


# main 

install_tar_pkg hadoop http://apache.cs.utah.edu/hadoop/common/stable/hadoop-1.2.1.tar.gz
install_tar_pkg hbase http://www.carfab.com/apachesoftware/hbase/stable/hbase-0.94.12.tar.gz

config_system_hadoop
