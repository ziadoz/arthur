# Arthur
A virtual machine environment for web development.

## Usage
Install the latest versions of the following:

- [VirtualBox](https://www.virtualbox.org/) with extensions pack
- [Vagrant](https://www.vagrantup.com/)
- [Ansible](https://www.ansible.com/) using [Homebrew](http://brew.sh/)

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

## Bash Aliases
Useful Bash aliases for working with Arthur:
```
arthur-go="cd ~/Projects/arthur && vagrant up && vagrant ssh"
arthur-up="cd ~/Projects/arthur && vagrant up"
arthur-halt="cd ~/Projects/arthur && vagrant halt"
arthur-destroy="cd ~/Projects/arthur && vagrant destroy"
```

## Todos
- Install Nginx (PPA), PHP7-FPM (PPA), MySQL 5.7 (PPA) or PostgreSQL, Redis, Elixir, Node JS and Phantom JS.
- Setup logrotate.
- Add tags to playbook tasks.
- Setup an Ansible vault with various passwords and settings in.
- Configure server timezone and locale.
- Sort out bash profile colours (look at Mathias Byens dotfiles) for Vagrant user account.
- Install [Passenger](https://www.phusionpassenger.com/library/install/nginx/install/oss/xenial/) to deploy Ruby and Node JS websites.
- Move PHP and MySQL config into `-custom.ini/cnf` files and copy them into the appropriate directories instead.
- Install Docker on server for potential deployments.

## Links
- https://serversforhackers.com/managing-logs-with-logrotate
- http://docs.ansible.com/ansible/playbooks_vault.html
