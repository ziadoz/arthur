# Arthur
A virtual machine environment for web development.

## Usage
Install the latest versions of the following:

- [Homebrew](http://brew.sh/)
- [VirtualBox](https://www.virtualbox.org/) with extensions pack
- [Vagrant](https://www.vagrantup.com/)
- [Ansible](https://www.ansible.com/)

After installing Homebrew you can quickly install the other dependencies:
```
brew install ansible
brew cask install vagrant virtualbox virtualbox-extension-pack
```

Now run the following command: `vagrant up`.

## Commands
To fix macOS Mojave Python issus:
```
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
```

Provision or re-provision the machine:
```
vagrant provision
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

Install the required roles:
```
ansible-galaxy install -r ansible/requirements.yml
```

Validate the playbook:
```
ansible-playbook ansible/playbook.yml --syntax-check
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

Start up headless Chrome and Selenium:
```
chromedriver --url-base=/wd/hub --whitelisted-ips=''
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

Remove SSH key:
```
ssh-keygen -R 192.168.33.42
```

## Todos
- Copy over stripped down PHP INI files for FPM and CLI.
- Clean up variables (`server.rtc`, `server.timezone`, `server.packages`, `php.extensions`, `node.packages` etc.)
- Remove Ruby.
- Install Redis, Beanstalkd and Mailhog.
- Swap task names to lowercase where applicable (e.g. `Install Chromedriver repository`).
- Move Vagrant bits (`inventory`, `ansible.cfg`, `Vagrantfile`) into `vagrant` sub directory.
- Add a `my.cnf` file to `$HOME` with credentials in for development.

## Future Improvements
- Use an Ansible vault to store passwords and settings.
- Use `:ansible_local` provisioner in `Vagrantfile` (issues with copying files).
- Install the VirtualBox guest additions [using Vagrant plugin](https://github.com/dotless-de/vagrant-vbguest).
- Use Packer to produce packaged boxes and store on Dropbox.
- Install MySQL using `.deb` file and using `debconf` to configure version and default root password.
- Look at [Laravel box provision script](https://github.com/laravel/settler/blob/master/scripts/provision.sh) for ideas.

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
