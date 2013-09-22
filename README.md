cookbooks
=========

chef cookbooks for managing tomcat/titan/rexster stacks with aws-opsworks

Features
--------
* download and install rexster-server, rexster-console and titan-hbase
* setup titan with rexster-server
* provide start/stop rexster receipts to work with aws OpsWorks stack management
* also contains a tomcat cookbook from [AWS OpsWorks demo cookbooks](http://https://github.com/amazonwebservices/opsworks-example-cookbooks).

Note
----
This is not a completely generic implementation, yet. The rexster.xml has hard-coded configurations for our particular use case, such as it supports hbase backend only etc.

