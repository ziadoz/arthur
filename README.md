# Arthur
A virtual machine environment for web development.

## Usage
Install the latest versions of the following:

- [Homebrew](http://brew.sh/)
- [VirtualBox](https://www.virtualbox.org/) with extensions pack
- [Vagrant](https://www.vagrantup.com/)
- [Ansible](https://www.ansible.com/)
- [Packer](packer.io/)

After installing Homebrew you can quickly install the other dependencies:
```
brew install ansible ansible-lint packer
brew cask install vagrant virtualbox virtualbox-extension-pack
```

Now run the following command: `vagrant up`.

## Host Commands
Build the box using Packer:
```
(cd packer && packer build --force template.json)
```

Bring up the virtual machine:
```
vagrant up
```

Remove SSH key:
```
ssh-keygen -R 192.168.33.42
```

Start up headless Chrome and Selenium (IP address whitelist is import to connect host to guest):
```
chromedriver --url-base=/wd/hub --whitelisted-ips=''
```

Access Mailcatcher at [https://192.168.33.42:1080](https://192.168.33.42:1080)

## Guest Commands
Start up headless Chrome and Selenium:
```
chromedriver --url-base=/wd/hub
```

Removing all virtualhost configurations:
```
rmsites
```

Symlinking a virtualhost configuration in the current directory:
```
lnsite
lnsite foo.conf
lnsite *-foo.conf
```

## Debug Commands
Lint the playbook:
```
ansible-lint ansible/playbook.yml
```

Validate the playbook:
```
ansible-playbook ansible/playbook.yml --syntax-check
```

Install the required roles:
```
ansible-galaxy install -r ansible/requirements.yml
```

Ping the inventory:
```
ansible all -m ping
```

Get facts about the inventory:
```
ansible all -m setup
ansible all -m setup > facts.json
```

Run tasks by tag:
```
ansible-playbook ansible/playbook.yml --tags "foo,bar"
ansible-playbook ansible/playbook.yml --skip-tags "foo,bar"
```

Run playbook on production:
```
ansible-playbook ansible/playbook.yml --ask-become-pass --limit production
ansible-playbook ansible/playbook.yml --ask-become-pass --limit production --tags user
```

Debug a playbook:
```
ansible-playbook -i 192.168.33.42, --user=vagrant --private-key=~/Projects/arthur/vagrant/.vagrant/machines/default/virtualbox/private_key --ssh-common-args="-o StrictHostKeyChecking=no" ansible/playbook.yml
```

To fix macOS Mojave Python issus:
```
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
```

To provision the virtual machine for further development, add these lines to `Vagrantfile`:
```
# Provision Debugging
config.vm.box = "ubuntu/bionic64"
config.vm.provision :ansible do |ansible|
    ansible.inventory_path = "inventory"
    ansible.playbook       = "ansible/playbook.yml"
    ansible.limit          = "development"
    ansible.verbose        = true
end
```

And then provision the VM:
```
vagrant provision
```

## Todos
- Swap Mailcatcher for Mailhog (no Ruby or dependencies needed).
- Clean up variables (`server.rtc`, `server.timezone`, `server.packages`, `php.extensions`, `node.packages` etc.)
- Install Beanstalkd.
- Swap task names to lowercase where applicable (e.g. `Install Chromedriver repository`).
- Fix Packer build red errors during user account creation and guest addition installation.
- Move configuration of PHP, MySQL etc. to an `init` provisioner in Vagrant,so it can easily be reloaded.
- Copy over stripped down PHP INI files for FPM and CLI during `init` role.
- Look at HTML5 Boilerplate issues when using `include h5bp/basic.conf`.

## Future Improvements
- Use an Ansible vault to store passwords and settings.
- Install the VirtualBox guest additions [using Vagrant plugin](https://github.com/dotless-de/vagrant-vbguest).
- Store packaged boxes on cloud storage (Dropbox, Google Drive).
- Look at [Laravel box provision script](https://github.com/laravel/settler/blob/master/scripts/provision.sh) for ideas.
- Look at using [existing Ansible Galaxy roles](https://galaxy.ansible.com/geerlingguy).
- Move Vagrant bits (`inventory`, `ansible.cfg`, `Vagrantfile`) into `vagrant` sub directory.

## Links
- https://serversforhackers.com/managing-logs-with-logrotate
- http://docs.ansible.com/ansible/playbooks_vault.html
- https://github.com/ansible/ansible/pull/22497
- https://github.com/geerlingguy/ansible-role-mysql/issues/42#issuecomment-278703603
- http://stackoverflow.com/questions/32429259/ansible-fails-with-bin-sh-1-usr-bin-python-not-found
- http://phptest.club/t/how-to-run-headless-chrome-in-codeception/1544
- http://docs.ansible.com/ansible/playbooks_best_practices.html#best-practices-for-variables-and-vaults
- https://www.jeffgeerling.com/blog/2018/use-ansibles-yaml-callback-plugin-better-cli-experience
- https://github.com/ansible/ansible/issues/34056
- https://linuxconfig.org/install-go-on-ubuntu-18-04-bionic-beaver-linux
