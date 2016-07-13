Vagrant.configure("2") do |config|
	config.vm.synced_folder "/home/Student", "/mnt", owner: "vagrant", group: "vagrant", create: true
	
  config.vm.define "web", primary: true do |web|
	web.vm.box = "sbeliakou/centos-6.7-x86_64"
	web.vm.hostname = "web"
	web.vm.network "private_network", ip: "192.168.25.10"
	
	web.vm.provider "virtualbox" do |machine|
		machine.name = "web-frontend"
		machine.memory = "512"
		machine.cpus = 1
	end
	web.vm.provision "shell", path: "web.sh"
  end	

  config.vm.define "app" do |app|
	app.vm.box = "sbeliakou/centos-6.7-x86_64"
	app.vm.hostname = "app"
	app.vm.network "private_network", ip: "192.168.25.11"
	app.vm.provider "virtualbox" do |machine|
		machine.name = "app"
		machine.memory = "1024"
		machine.customize ["modifyvm", :id, "--cpuexecutioncap", "35"]
		machine.cpus = 1
	end
	app.vm.provision "shell", path: "app.sh"
  end  

config.vm.provision "shell", inline: "All configurations were installed!"
end
