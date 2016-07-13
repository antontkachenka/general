#!/bin/bash

# Install httpd
sudo yum install httpd -y 
sudo chkconfig httpd on 
sudo /etc/init.d/httpd start 

# Install, configure mod_jk
sudo yum install httpd-devel apr apr-devel apr-util apr-util-devel gcc gcc-c++ make autoconf libtool -y
cd /opt
sudo wget http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.41-src.tar.gz
sudo tar -xvzf tomcat-connectors-1.2.41-src.tar.gz
cd tomcat-connectors-1.2.41-src/native 
sudo ./configure --with-apxs=/usr/sbin/apxs --enable-api-compatibility
sudo make
sudo make install
sudo cp /opt/tomcat-connectors-1.2.41-src/native/apache-2.0/mod_jk.so /etc/httpd/modules/

#Configure httpd
cd /etc/httpd/conf
sudo touch workers.properties
sudo chmod 777 workers.properties
sudo echo "worker.list=worker1" >> workers.properties
sudo echo "worker.worker1.port=8009" >> workers.properties
sudo echo "worker.worker1.host=192.168.25.11" >> workers.properties
sudo echo "worker.worker1.type=ajp13" >> workers.properties
sudo echo "worker.worker1.lbfactor=1" >> workers.properties

sudo chmod 777 httpd.conf
sudo echo "LoadModule jk_module /etc/httpd/modules/mod_jk.so" >> httpd.conf 
sudo echo "JkWorkersFile /etc/httpd/conf/workers.properties" >> httpd.conf
sudo echo "<VirtualHost 192.168.25.10:80>" >> httpd.conf
sudo echo "ServerName 192.168.25.10" >> httpd.conf
sudo echo "JkMount /* worker1" >> httpd.conf
sudo echo "</VirtualHost>" >> httpd.conf
sudo echo "" >> httpd.conf

sudo service httpd restart  
