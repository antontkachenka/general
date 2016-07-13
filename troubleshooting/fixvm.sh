#!/bin/bash

echo "Start fixing troubles."
#Fix file httpd.conf
cd /etc/httpd/conf/
sed -i '/^<\/VirtualHost>$/d' httpd.conf
sed -i '/    ErrorDocument*/d' httpd.conf
sed -i '/^<VirtualHost..:80>$/d' httpd.conf
sed -i '/    Redirect "\/" "http:\/\/mntlab\/"/d' httpd.conf

#Fix vhost.conf
cd /etc/httpd/conf.d/
sed -i 's/mntlab:80/\*:80/' vhost.conf

#Fix starting tomcat
cd /home/tomcat/
sed -i '/export JAVA_HOME=\/tmp/d' .bashrc
sed -i '/export CATALINA_HOME=\/tmp/d' .bashrc
chown tomcat:tomcat /opt/apache/tomcat/current/logs/

#Fix workers.properties
cd /etc/httpd/conf.d/
sed -i 's/worker-jk@ppname/tomcat.worker/g' workers.properties
sed -i 's/192.168.56.100/192.168.56.10/' workers.properties

#Fix iptable 
cd /etc/sysconfig/
sudo chattr -i iptables
sudo sed -i '9a\-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT\' iptables
sudo sed -i 's/RELATED/ESTABLISHED,RELATED/' iptables
#sudo service iptables save
sudo sed -i '13a\ \' iptables
sudo service iptables stop
sudo service iptables start

#Add Tomcat to autoboot
sudo chkconfig --add tomcat
sudo chkconfig --level 2345 tomcat on

#chose alternatives
sudo alternatives --config java <<< 1

#restart service
sudo service httpd restart
sudo service tomcat start
echo "Stop fixing troubles, restart Virtual Machine."

#Change connector address to "127.0.0.1" for protocol "AJP/1.3"
sed -i 's/Connector address="192.168.56.10" port="8009"/Connector address="127.0.0.1" port="8009"/' /opt/apache/tomcat/current/conf/server.xml
sed -i 's/192.168.56.10/127.0.0.1/' /etc/httpd/conf.d/workers.properties
