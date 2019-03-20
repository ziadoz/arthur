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

## Bash
Here's a useful Bash function for that makes working with Vagrant commands easier:
```
export ARTHUR_DIR="$HOME/Projects/arthur"

arthur () {
    for arg in "$@"; do
        if [ "$arg" == "rmssh" ]; then
            ssh-keygen -R 192.168.33.42
        else
            (cd "$ARTHUR_DIR" && vagrant "$arg")
        fi

        if [ "$?" != "0" ]; then
            return $?
        fi
    done
}
```

You can use it like this:
```
# Run one command:
arthur up

# Run multiple commands:
arthur up ssh
arthur halt destroy

# Remove SSH key from known hosts:
arthur rmssh
```

## Todos
- Copy over PHP INI files for FPM and CLI.
- Use maps for role variables (e.g. `server.locale` to `server.locale`).
- Extract packages into variables (e.g. `ruby.dependencies` and `ruby.packages`).
- Install Redis, [Passenger](https://www.phusionpassenger.com/library/install/nginx/install/oss/xenial/), Docker and Log Rotate.

## Future Improvements
- Use an Ansible vault to store passwords and settings.
- Use `:ansible_local` provisioner in `Vagrantfile` (issues with copying files).
- Install the VirtualBox guest additions [using Vagrant plugin](https://github.com/dotless-de/vagrant-vbguest).
- Use Packer to produce builds, add an `arthur-build` alias, and store on Dropbox.
- Install MySQL using `.deb` file and using debconf to configure version and default root password.
- Revert to an LTS version of Ubuntu for less hassle and more stability.

## Links
- https://serversforhackers.com/managing-logs-with-logrotate
- http://docs.ansible.com/ansible/playbooks_vault.html
- https://github.com/ansible/ansible/pull/22497
- https://github.com/geerlingguy/ansible-role-mysql/issues/42#issuecomment-278703603
- http://stackoverflow.com/questions/32429259/ansible-fails-with-bin-sh-1-usr-bin-python-not-found
- http://phptest.club/t/how-to-run-headless-chrome-in-codeception/1544
- http://docs.ansible.com/ansible/playbooks_best_practices.html#best-practices-for-variables-and-vaults
- https://www.jeffgeerling.com/blog/2018/use-ansibles-yaml-callback-plugin-better-cli-experience
