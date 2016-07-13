At first, in this progect I installed Vagrant and Virtualbox:
![alt text](https://github.com/antontkachenka/mntlab/blob/master/vagrant/source/1.png "Pic 1")
Used specific vagrant box:
vagrant box add sbeliakou/centos-6.7-x86_64 /Home/Studen/Desktop/sbeliakou-vagrant-centos-6.7-x86_64.box

After I installed two VM, wich act as front-end (web) and back-end (app) servers:
![alt text](https://github.com/antontkachenka/mntlab/blob/master/vagrant/source/2.png "Pic 2")
VMs’ settings:
 -VM1: 
 machine.memory = "512"
 machine.cpus = 1

 -VM2:
 machine.memory = "1024"
 machine.customize ["modifyvm", :id, "--cpuexecutioncap", "35"]
 machine.cpus = 1

 Mount host directories into VMs: 
 mnt on /mnt type vboxsf (uid=500,gid=500,rw)
 
After that I wrote script, wich automaticaly deploy httpd and tomcat servers, connected them on servers wich I installed erlier (web and app). On last screenshot I showed that we can connect to web server over IP and get tomcat's start-page: 
![alt text](https://github.com/antontkachenka/mntlab/blob/master/vagrant/source/8.png "Pic 3")

Directory "sourse" contains only screenshots for task. 

File "vagrantfile" contains config for deployment two VM over Virtualbox.

File "web.sh" contains scripts for deployment httpd and mod_jk. 

File "app.sh" contains scripts for deployment tomcat.
