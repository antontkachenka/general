No | Issue | How to Find | Time to find (min)| Hot to fix | Time to fix (min)
---| :---: | :---: | :---: | :---: | :---: |
1 | Web-site doesn't open | Run in global terminal: curl -IL http://192.168.56.10 When I try to open site, 302 code appears. Run in local terminal: curl -IL http://192.168.56.10 When I try to open site, at first 302 code appears, after 503 code appears |  5 min | I see that block virtualhost there is in httpd.conf and included  vhost.conf. Open httpd.conf and delete block virtualhost.../virtualhost | 15 min
2 | Web-site doesn't open | Run in global and local terminal curl -IL – see different code. | 10 min |Open httpd.conf, find how to called logs file. Open log file and can that some requests were not directed to virtualhost. Open vhost.conf and edit virtualhost mntlab:80 by changing “mntlab” to “*”| 15 min
3 | Web-site doesn't open. Problem with tomcat. | Run in global and local terminal curl -IL – see 503 code. Ps -ef shows that tomcat doesn't start | 5 min | Open /etc/init.d/tomcat and see, that user tomcat try to start tomcat. Change user to tomcat. Try to start tomcat and see error “Cannot find /tmp/bin/setclasspath.sh”. Try to open by less “startup.sh”, don't find link to “setclasspath.sh”, but see executable file “catalina.sh”. Open catalina.sh and find link to “setclasspath.sh”. See variable “CATALINA_HOME”. Open $CATALINA_HOME in terminal and see answer /tmp. Try to fix it by editing ~/.bash_profile over user tomcat. There is not variable $CATALINA_HOME here, but I see link to ~/.bashrc. Open .bashrc and see two variables $CATALINA_HOME and $JAVA_HOME. Comment or delete it. Try to start “startup.sh” - See error that tomcat can't touch log-file in logs directories. Change own of the directories “logs” to tomcat. | 40 min
4 | Web-site doesn't open. Problem with tomcat. | In catalina.out I find error about: /usr/bin/java: /lib/ld-linux.so.2: bad ELF interpreter: No such file or directory | 10 min | Chose another alternatives in “alternatives - -config java”  | 5 min
5 | Web-site doesn't open. | Run in global and local terminal curl -IL – see 503 code. | 5 min | Open vhost.conf and find where the mod-jk log-file. In log-file see error “failed to connect tomcat”. Open workers.properties. Fix name of worker in last 3 rows (change worker-jk@ppname to  tomcat.worker) and fix IP to correct 192.168.56.10. Restart httpd. Run in global and local terminal curl -IL – see 200 code. | 15 min
6 | ptables doesn's start. | Run sudo service iptables status | 5 min | Edit iptables by adding parameter “ESTABLISHED” in “-A INPUT -m state --state RELATED -j ACCEPT” and input 80 port. | 15 min
7 | Record's aren't added to iptables | Try to add records to iptables | 1 min | Check  lsattr and see attribute “i” from file iptables. By command “chattr -i” deleting this attribute and fix iptables like a previous step.| 10 min

Also I chanched connection IP for worker to 127.0.0.1 

What java version is installed?
Type “java -version” in terminal:
java version "1.7.0_79"
Java(TM) SE Runtime Environment (build 1.7.0_79-b15)
Java HotSpot(TM) 64-Bit Server VM (build 24.79-b02, mixed mode

How was it installed and configured?
It was installed in “/opt/oracle/java/x64//jdk1.7.0_79/bin/java” directory and configured by alternatives

Where are log files of tomcat and httpd?
Httpd: Errorlog and customlog located in the directory logs. I found this place in httpd.conf
tomcat: /opt/apache/tomcat/7.0.62/ logs

Where is JAVA_HOME and what is it?
JAVA_HOME – it is variable, that point at your Java Development Kit installation.
It is located in /opt/oracle/java/x64/jdk1.7.0_79 

Where is tomcat installed?
Tomcat is installed in /opt/apache/tomcat/7.0.62

What is CATALINA_HOME?
It is variable, that point at your Catalina directory

What users run httpd and tomcat processes? How is it configured?
Tomcat is ran TOMCAT user. IT is configured in /etc/init.d/tomcat
Httpd is ran appache user. It is configured in httpd.conf

What configuration files are used to make components work with each other?
Vhost.conf, httpd.conf, server.xml and workers.properties are used to make components work with each other.

What does it mean: “load average: 1.18, 0.95, 0.83”?
Load Average is the average number of processes waiting for the CPU resources of the three time periods: 1.18  for 1 minute, 0.95  for 5 minutes and 0.83  for 15 minutes.
