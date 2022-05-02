Vagrant.configure("2") do |configuration|
  configuration.vm.box = "ubuntu/focal64"
  configuration.vm.network "private_network", ip: ENV["IP"]
  configuration.vm.provision "shell", path: "scripts/provision.sh"
  configuration.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end
end
