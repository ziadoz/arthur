# Arthur
A virtual environment for web development.

## Todos
- Install Nginx (PPA), PHP7-FPM (PPA), MySQL 5.7 (PPA) or PostgreSQL, Elixir, Node JS and Phantom JS.
- Configure PHP-FPM with custom INI file.
- Setup logrotate.
- Add tags to playbook tasks.
- Revise virtual host Ruby script: https://gist.github.com/ziadoz/63efdb096123ec88271f

## Commands

```
ansible all -m ping
ansible all -m setup
```

## Links
- http://www.jeffgeerling.com/blog/using-ansible-galaxy
- http://stackoverflow.com/questions/25230376/how-to-automatically-install-ansible-galaxy-roles
- https://galaxy.ansible.com/ferrarimarco/install-roles/
