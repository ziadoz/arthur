# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # Box
  config.vm.hostname = "arthur"
  config.vm.box      = "ubuntu/bionic64"
  config.vm.network "private_network", ip: "192.168.33.42"

  # Shared Folders
  config.vm.synced_folder "~/Projects", "/var/www/vhosts", id: "sites"
  config.vm.synced_folder "~/Go", "/opt/go", id: "go"

  # Configuration
  config.vm.provider "virtualbox" do |vb|
    vb.name   = "arthur"
    vb.memory = "2048"
  end

  # Provisioning
  config.vm.provision :ansible do |ansible|
    ansible.inventory_path = "inventory"
    ansible.playbook       = "ansible/playbook.yml"
    ansible.limit          = "development"
    ansible.verbose        = true
  end
end
