# Arthur
A virtual environment for web development.

## Todos
- Install Nginx (PPA), PHP7-FPM (PPA), MySQL 5.7 (PPA) or PostgreSQL, Redis, Elixir, Node JS and Phantom JS.
- Setup logrotate.
- Add tags to playbook tasks.
- Revise virtual host Ruby script: https://gist.github.com/ziadoz/63efdb096123ec88271f

## Commands
Provision or re-provision the machine: `vagrant provision`

Ping the inventory: `ansible all -m ping`

Get facts about the inventory: `ansible all -m setup`

Install the required roles: `ansible-galaxy install -r requirements.yml`

Validate the playbook: `ansible-playbook playbook.yml --check`

## Links
- http://leucos.github.io/ansible-files-layout/
- http://www.jeffgeerling.com/blog/using-ansible-galaxy
- http://stackoverflow.com/questions/25230376/how-to-automatically-install-ansible-galaxy-roles
- https://galaxy.ansible.com/ferrarimarco/install-roles/
