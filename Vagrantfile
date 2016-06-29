# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # Box
  config.vm.hostname = "arthur"
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "private_network", ip: "192.168.33.42"

  # Shared Folder
  config.vm.synced_folder "~/Projects", "/var/www/vhosts", type: "nfs"

  # Configuration
  config.vm.provider "virtualbox" do |vb|
    vb.name   = "arthur"
    vb.memory = "2048"
  end

  # Provisioning
  config.vm.provision :ansible do |ansible|
    ansible.inventory_path = "ansible/hosts"
    ansible.playbook       = "ansible/playbook.yml"
    ansible.limit          = "all"
    ansible.verbose        = true
  end
end
