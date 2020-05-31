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

Run tasks with extra variables:
```
ansible-playbook ansible/playbook.yml --extra-vars="user_account=foobar"
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
config.vm.box = "bento/ubuntu-18.04"
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

You can make daily usage easier with this handy alias: 
```
function arthur() {
    (cd ~/Projects/arthur && vagrant $*)
}
```

## Future Improvements
Potential improves and ideas to improve Arthur.
- Clean up variables (`server.rtc`, `server.timezone`, `server.packages`, `php.extensions`, `node.packages` etc.)
- Swap task names to lowercase where applicable (e.g. `Install Chromedriver repository`).
- Move configuration of PHP, MySQL etc. to an `init` provisioner in Vagrant,so it can easily be reloaded.
- Copy over stripped down PHP INI files for FPM and CLI during an `init` role.
- Use an Ansible vault to store passwords and settings.
- Store packaged boxes on cloud storage (Dropbox, Google Drive).
- Look at using [existing Ansible Galaxy roles](https://galaxy.ansible.com/geerlingguy).
- Move Vagrant bits (`inventory`, `ansible.cfg`, `Vagrantfile`) into `vagrant` sub directory.
- Add `/etc/hosts` file with domains in for projects so internal requests resolve.
- Load YAML file in `Vagrantfile` that contains project folders to sync, host names, CPU cores, RAM, and other settings.

### Software
Software to consider adding in the future. 
- Upgrade to Ubuntu 20.04 LTS.
- Swap Mailcatcher for Mailhog (no Ruby and dependencies needed).
- Add Caddy webserver.
- Add Apache webserver.
- Add Postgres database.
- Install Beanstalkd.
- Use [Vagrant Guest Additions Plugin](https://github.com/dotless-de/vagrant-vbguest)
- Use [Vagrant Hostsupdater Plugin](https://github.com/cogitatio/vagrant-hostsupdater).
- Use [Vagrant Disk Size Plugin](https://github.com/sprotheroe/vagrant-disksize).

### Alternatives
Alternatives to this VM, mostly for reference.
- [Laravel Homestead](https://laravel.com/docs/master/homestead)
- [Laravel Valet](https://laravel.com/docs/master/valet)
- [DBngin](https://dbngin.com/)

## Links
Links that have been useful for development and debugging. 
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
- https://github.com/laravel/settler/blob/master/scripts/provision.sh
- https://github.com/laravel/homestead/blob/master/Vagrantfile
- https://bizwind.github.io/2019-06-26/improving-synced-folder-performance-in-vagrant
- https://bugs.launchpad.net/ubuntu/+source/apt/+bug/1785778
- https://askubuntu.com/questions/41605/trouble-downloading-packages-list-due-to-a-hash-sum-mismatch-error
- https://stackoverflow.com/questions/49822594/vagrant-how-to-specify-the-disk-size
- https://virtualzero.net/blog/how-to-install-virtualbox-guest-additions-in-ubuntu-server-18.04-lts
- https://kifarunix.com/install-virtualbox-guest-additions-on-ubuntu-18-04/
- https://www.linuxquestions.org/questions/linux-virtualization-and-cloud-90/how-to-check-version-of-virtualbox-guest-additions-currently-installed-in-guest-syste-946053/
- https://mysqlserverteam.com/mysql-8-0-collations-migrating-from-older-collations/

## Debug
Raw Bento Box URL: https://vagrantcloud.com/bento/boxes/ubuntu-18.04/versions/202005.21.0/providers/virtualbox.box
