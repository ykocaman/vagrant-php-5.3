Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/precise64"

	config.vm.provider "virtualbox" do |vb| 
		vb.memory = "1024"
		vb.cpus = "2"
	end

	config.vm.network :private_network, ip: "192.168.10.10"
	config.vm.network :forwarded_port, guest: 80, host: 8080

	config.ssh.forward_agent = true

	config.vm.synced_folder "./", "/host/"
	config.vm.synced_folder "config/apache/", "/etc/apache2/sites-enabled/"

	# Project path
	config.vm.synced_folder "local-project-path", "/var/www/app/"

	config.vm.provision :shell, :path => "install.sh"
end
