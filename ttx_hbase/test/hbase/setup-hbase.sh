#!/bin/bash

#JAVA_HOME=/usr/java/jdk1.7.0_40

####### variables

HBASE_HOME=/home/hadoop
PREV_HBASE=hbase0.92 

#==== prepapre ami ====

#install java7 
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

#install hadoop rpm
function install_hadoop {
        echo "install hadoop"

        HADOOP_DOWNLOAD_URL=http://apache.cs.utah.edu/hadoop/common/stable/hadoop-1.2.1-1.x86_64.rpm
        HADOOP_PKG=`echo $HADOOP_DOWNLOAD_URL | sed "s/.*\///g"`

        wget $HADOOP_DOWNLOAD_URL
        sudo rpm -i $HADOOP_PKG
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
}


#### install hbase ####
function hbase_env {

    HBASE_DOWNLOAD_URL=http://www.carfab.com/apachesoftware/hbase/stable/hbase-0.94.12.tar.gz
    HBASE_PKG=`echo $HBASE_DOWNLOAD_URL | sed "s/.*\///g"`
    HBASE_INSTALL_DIR=`echo $HBASE_PKG| sed "s/\.tar\.gz//"`
    HBASE_REPOSITORY=$HBASE_HOME/.versions/$HBASE_INSTALL_DIR
}

function download_hbase {

    if [ ! -d "$HBASE_REPOSITORY" ]; then

	cd /tmp
        sudo rm -rf $HBASE_PKG
        sudo rm -rf $HBASE_INSTALL_DIR

        wget $HBASE_DOWNLOAD_URL
        tar xf $HBASE_PKG

        sudo mv $HBASE_INSTALL_DIR $HBASE_REPOSITORY

    else
        echo "$HBASE_REPOSITORY already exist"
    fi

}

function config_system_hbase {

    arch=`arch`
    cd $HBASE_HOME
    sudo sbin/update-hbase-env.sh --prefix /usr --arch $arch --bin-dir $HBASE_HOME/bin --conf-dir $HBASE_HOME/conf --log-dir /var/log/hbase --pid-dir /var/run
}

function setup_hbase {
    if [ ! -f $HBASE_HOME/lib/${HBASE_INSTALL_DIR}.jar ]; then
	cp $HBASE_HOME/.versions/${HBASE_INSTALL_DIR}/${HBASE_INSTALL_DIR}.jar $HBASE_HOME/lib/${HBASE_INSTALL_DIR}.jar
	rm -f $HBASE_HOME/lib/hbase.jar
	ln -s $HBASE_HOME/lib/${HBASE_INSTALL_DIR}.jar $HBASE_HOME/lib/hbase.jar
    else
	echo "skip $HBASE_HOME/lib/${HBASE_INSTALL_DIR}.jar"
    fi
}

# main 

### JDK
#install_jdk

### hadoop
#install_hadoop
#config_system_hadoop

### hbase
hbase_env
#download_hbase 
setup_hbase
#config_system_hbase 


