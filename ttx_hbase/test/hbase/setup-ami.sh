#!/bin/bash

#JAVA_HOME=/usr/java/jdk1.7.0_40

####### variables

SCRIPT_DIR=$(cd $(dirname "$0"); pwd)

source $SCRIPT_DIR/hbase-env.sh

#==== prepapre ami ====

####### install java7  #####
function install_jdk {
    echo "install jdk"

    JAVA_DOWNLOAD_URL=http://download.oracle.com/otn-pub/java/jdk/7u40-b43/jdk-7u40-linux-x64.rpm
    JAVA_PKG_VERSION=jdk1.7.0_40
    JAVA_PKG=`echo $JAVA_DOWNLOAD_URL | sed "s/.*\///g"`

    wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" $JAVA_DOWNLOAD_URL

    sudo rpm -i $JAVA_PKG

    sudo /usr/sbin/alternatives --install /usr/bin/java java /usr/java/${JAVA_PKG_VERSION}/bin/java 20000
    sudo /usr/sbin/alternatives --config java

    java -version
    echo "set JAVA_HOME to  /usr/java/${JAVA_PKG_VERSION}"
}

#### install hadoop rpm #######
function install_hadoop_rpm {
        echo "install hadoop (rpm)"

        HADOOP_DOWNLOAD_URL=http://apache.cs.utah.edu/hadoop/common/stable/hadoop-1.2.1-1.x86_64.rpm
        HADOOP_PKG=`echo $HADOOP_DOWNLOAD_URL | sed "s/.*\///g"`

        wget $HADOOP_DOWNLOAD_URL
        sudo rpm -i $HADOOP_PKG
}

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


#install hbase rpm
function download_hbase {

    HBASE_DOWNLOAD_URL=http://www.carfab.com/apachesoftware/hbase/stable/hbase-0.94.12.tar.gz
    HBASE_PKG=`echo $HBASE_DOWNLOAD_URL | sed "s/.*\///g"`
    HBASE_INSTALL_DIR=`echo $HBASE_PKG| sed "s/\.tar\.gz//"`

    if [ ! -d "$HBASE_HOME" ]; then

	cd /tmp
        sudo rm -rf $HBASE_PKG
        sudo rm -rf $HBASE_INSTALL_DIR

        wget $HBASE_DOWNLOAD_URL
        sudo tar xf $HBASE_PKG

	# copy to our package directory : /opt
	sudo mkdir -p /opt
	sudo rm -rf /opt/$HBASE_INSTALL_DIR
        sudo mv $HBASE_INSTALL_DIR /opt

	sudo ln -s /opt/$HBASE_INSTALL_DIR $HBASE_HOME

    else
        echo "$HBASE_HOME already exist"
    fi

}

function config_system_hbase {

    arch=`arch`
    cd $HBASE_HOME
    sudo sbin/update-hbase-env.sh --prefix /usr --arch $arch --bin-dir $HBASE_HOME/bin --conf-dir $HBASE_HOME/conf --log-dir /var/log/hbase --pid-dir /var/run
}

# main 

### JDK
#install_jdk

### hadoop
#install_hadoop
#config_system_hadoop

### hbase
#download_hbase 
#config_system_hbase 

install_tar_pkg hadoop http://apache.cs.utah.edu/hadoop/common/stable/hadoop-1.2.1.tar.gz
install_tar_pkg hbase http://www.carfab.com/apachesoftware/hbase/stable/hbase-0.94.12.tar.gz

config_system_hadoop
