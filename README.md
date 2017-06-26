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
brew install vagrant ansible
brew cask install virtualbox virtualbox-extension-pack
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
ansible-playbook ansible/playbook.yml --check
```

Run tasks by tag:
```
ansible-playbook ansible/playbook.yml --tags "foo,bar"
ansible-playbook ansible/playbook.yml --skip-tags "foo,bar"
```

Start up headless Chrome and Selenium:
```
chrome-headless
xvfb-run java -Dwebdriver.chrome.driver=/usr/local/bin/chromedriver -jar /usr/local/bin/selenium-server-standalone-x.x.x.jar -debug
```

## Bash Aliases
Useful Bash aliases for working with Arthur:
```
export ARTHUR_DIR="~/Projects/arthur"

alias arthur-go="(cd $ARTHUR_DIR && vagrant up && vagrant ssh)"
alias arthur-up="(cd $ARTHUR_DIR && vagrant up)"
alias arthur-ssh="(cd $ARTHUR_DIR && vagrant up && vagrant ssh)"
alias arthur-halt="(cd $ARTHUR_DIR && vagrant halt)"
alias arthur-destroy="(cd $ARTHUR_DIR && vagrant destroy)"
alias arthur-provision="(cd $ARTHUR_DIR && vagrant provision)"
```

## Todos
- Upgrade to latest version of Ubuntu.
- Namespace role variables (e.g. `server_locale` to `server.locale`).
- Extract packages into variables (e.g. `ruby.dependencies` and `ruby.packages`).
- Setup an Ansible vault with various passwords and settings in.
- Install Redis, [Passenger](https://www.phusionpassenger.com/library/install/nginx/install/oss/xenial/), and Docker.
- Setup logrotate.
- Add tags to playbook tasks.
- Move PHP and MySQL config into `-custom.ini/cnf` files and copy them into the appropriate directories instead.
- Look at writing a script to [package up](https://www.vagrantup.com/docs/cli/package.html) a built box.
- Investigate only exposing certain ports (e.g. MySQL) if is VM build.

## Links
- https://serversforhackers.com/managing-logs-with-logrotate
- http://docs.ansible.com/ansible/playbooks_vault.html
- https://github.com/ansible/ansible/pull/22497
- https://github.com/geerlingguy/ansible-role-mysql/issues/42#issuecomment-278703603
- http://stackoverflow.com/questions/32429259/ansible-fails-with-bin-sh-1-usr-bin-python-not-found
