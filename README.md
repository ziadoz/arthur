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
chrome-headless
chromedriver --url-base=/wd/hub --port=4444
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

## Bash Aliases
Useful Bash aliases for working with Arthur:
```
export ARTHUR_DIR="~/Projects/arthur"

alias arthur-up="(cd $ARTHUR_DIR && vagrant up)"
alias arthur-ssh="(cd $ARTHUR_DIR && vagrant up && vagrant ssh)"
alias arthur-ssh-rm="ssh-keygen -R 192.168.33.42"
alias arthur-halt="(cd $ARTHUR_DIR && vagrant halt)"
alias arthur-destroy="(cd $ARTHUR_DIR && vagrant destroy)"
alias arthur-provision="(cd $ARTHUR_DIR && vagrant provision)"
```

## Todos
- Copy over PHP INI files for FPM and CLI.
- Use maps for role variables (e.g. `server.locale` to `server.locale`).
- Extract packages into variables (e.g. `ruby.dependencies` and `ruby.packages`).
- Install Redis, [Passenger](https://www.phusionpassenger.com/library/install/nginx/install/oss/xenial/), Docker and Log Rotate.

## Future Improvements
- Use an Ansible vault to store passwords and settings.
- Use `:ansible local` provisioner in `Vagrantfile` (issues with copying files).
- Install the VirtualBox guest additions [using Vagrant plugin](https://github.com/dotless-de/vagrant-vbguest).
- Use Packer to produce builds, add an `arthur-build` alias, and store on Dropbox.

## Links
- https://serversforhackers.com/managing-logs-with-logrotate
- http://docs.ansible.com/ansible/playbooks_vault.html
- https://github.com/ansible/ansible/pull/22497
- https://github.com/geerlingguy/ansible-role-mysql/issues/42#issuecomment-278703603
- http://stackoverflow.com/questions/32429259/ansible-fails-with-bin-sh-1-usr-bin-python-not-found
- http://phptest.club/t/how-to-run-headless-chrome-in-codeception/1544
- http://docs.ansible.com/ansible/playbooks_best_practices.html#best-practices-for-variables-and-vaults
