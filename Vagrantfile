# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # Box
  config.vm.hostname = "arthur"
  config.vm.box      = "arthur"
  config.vm.box_url  = "arthur"
  config.vm.network "private_network", ip: "192.168.33.42"

  # Shared Folders
  config.vm.synced_folder "~/Projects", "/var/www/vhosts", id: "sites", type: "nfs", mount_options: ["nolock", "vers=3", "udp", "noatime", "actimeo=1"]

  # Configuration
  config.vm.provider "virtualbox" do |vb|
    vb.name   = "arthur"
    vb.memory = 2048
  end
end
