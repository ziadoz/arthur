# Arthur
A virtual machine environment for web development.

## Usage
Install the latest versions of the following:

- [VirtualBox](https://www.virtualbox.org/) with extensions pack
- [Vagrant](https://www.vagrantup.com/)
- [Ansible](https://www.ansible.com/) using [Homebrew](http://brew.sh/)

Now run the following command: `vagrant up`.

## Todos
- Install Nginx (PPA), PHP7-FPM (PPA), MySQL 5.7 (PPA) or PostgreSQL, Redis, Elixir, Node JS and Phantom JS.
- Setup logrotate.
- Add tags to playbook tasks.
- Revise virtual host Ruby script using Bash and `find` instead: https://gist.github.com/ziadoz/63efdb096123ec88271f
- Setup an Ansible vault with various passwords and settings in.
- Sort out bash profile colours (look at Mathias Byens dotfiles) for Vagrant user account.
- Install [Passenger](https://www.phusionpassenger.com/library/install/nginx/install/oss/xenial/) to deploy Ruby and Node JS websites.
- Move PHP and MySQL config into `-custom.ini/cnf` files and copy them into the appropriate directories instead.

## Commands
Provision or re-provision the machine: `vagrant provision`

Ping the inventory: `ansible all -m ping`

Get facts about the inventory: `ansible all -m setup`

Install the required roles: `ansible-galaxy install -r requirements.yml`

Validate the playbook: `ansible-playbook playbook.yml --check`

Run tasks by tag: `ansible-playbook playbook.yml --tags "foo,bar"` or `ansible-playbook playbook.yml --skip-tags "foo,bar"`

## Links
- http://leucos.github.io/ansible-files-layout/
- http://www.jeffgeerling.com/blog/using-ansible-galaxy
- http://stackoverflow.com/questions/25230376/how-to-automatically-install-ansible-galaxy-roles
- https://galaxy.ansible.com/ferrarimarco/install-roles/
- https://serversforhackers.com/managing-logs-with-logrotate
- http://docs.ansible.com/ansible/playbooks_vault.html
- http://stackoverflow.com/questions/4034896/find-all-files-with-a-filename-beginning-with-a-specified-string-which-may-match
