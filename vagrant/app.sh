#!/bin/bash

#Instal, start Tomcat (and install java for tomcat)
cd /usr/local/
sudo mkdir tomcat
cd tomcat
sudo wget http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-8/v8.0.36/bin/apache-tomcat-8.0.36.zip
sudo yum install zip -y
sudo yum install unzip -y
sudo unzip apache-tomcat-8.0.36.zip
cd apache-tomcat-8.0.36/bin
sudo yum install java -y
sudo chmod +x *.sh
sudo ./startup.sh 

