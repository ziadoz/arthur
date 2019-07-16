# -*- mode: ruby -*-
# vi: set ft=ruby :

# Build Box
if ! File.exists?("#{__dir__}/packer/output/package.box")
  system("(cd #{__dir__}/packer && packer build --force template.json)")
end

Vagrant.configure(2) do |config|
  # Box
  config.vm.hostname = "arthur"
  config.vm.box      = "arthur"
  config.vm.box_url  = "file://packer/output/package.box"
  config.vm.network "private_network", ip: "192.168.33.42"

  # Shared Folders
  config.vm.synced_folder "~/Projects", "/var/www/vhosts", id: "sites", type: "nfs"
  config.vm.synced_folder "~/Go", "/opt/go", id: "go", type: "nfs"

  # Configuration
  config.vm.provider "virtualbox" do |vb|
    vb.name   = "arthur"
    vb.memory = 2048
  end
end
