# Arthur
A virtual environment for web development.

## To Dos
- Setup logrotate
- Check where network cron ends up
- Setup Nginx, MySQL, PHP7, PostgreSQL
- Add tags to playbook rules
- Change Vagrant user to ziadoz (config.ssh.user?) and update ansible.cfg to use it too?
- Disable UFW logging on VM

## Resources
- http://docs.ansible.com/ansible/playbooks_best_practices.html
- http://docs.ansible.com/ansible/playbooks_lookups.html
- http://docs.ansible.com/ansible/playbooks_conditionals.html
- http://docs.ansible.com/ansible/intro_adhoc.html
- http://docs.ansible.com/ansible/playbooks_variables.html
- http://blog.scottlowe.org/2015/06/08/using-vagrant-to-learn-ansible/
- http://lattejed.com/first-five-and-a-half-minutes-on-a-server-with-ansible
- http://plusbryan.com/my-first-5-minutes-on-a-server-or-essential-security-for-linux-servers
- https://help.ubuntu.com/community/AutomaticSecurityUpdates
- https://wiki.debian.org/UnattendedUpgrades
- https://gist.github.com/garethrees/5591027
- https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-14-04
- http://www.thedreaming.org/2014/11/04/vagrant-ansible/
- http://codepoets.co.uk/2014/ansible-random-things/
- https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04
- https://www.digitalocean.com/community/questions/delete-swap-file
- https://www.digitalocean.com/community/questions/how-to-delete-a-swap-file
- https://github.com/kamaln7/ansible-swapfile
- http://rosstuck.com/multistage-environments-with-ansible/
- https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-14-04
- http://toschas.com/rbenv-setting-it-up-globally/
- http://stackoverflow.com/questions/1381725/how-to-make-no-ri-no-rdoc-the-default-for-gem-install
- http://stackoverflow.com/questions/27733511/how-to-set-linux-environment-variables-with-ansible
- http://mmoya.org/blog/2013/02/22/installing-rubyrbenv-with-ansible/
- http://bencane.com/2013/09/16/understanding-a-little-more-about-etcprofile-and-etcbashrc/
- http://dan.carley.co/blog/2012/02/07/rbenv-and-bundler/
- http://blakewilliams.me/posts/system-wide-rbenv-install/
- http://superuser.com/questions/277775/ensuring-new-files-in-a-directory-belong-to-the-group
- https://blog.dbrgn.ch/2014/6/17/setting-setuid-setgid-bit-with-ansible/
- http://unix.stackexchange.com/questions/128220/how-do-i-set-my-dns-when-resolv-conf-is-being-overwritten
- https://github.com/ansible/ansible/issues/4854
- http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
- https://fijiaaron.wordpress.com/2015/06/18/using-pyenv-with-virtualenv-and-pip-cheat-sheet/

```
# OS Memory: https://stefanwrobel.com/how-to-make-vagrant-performance-not-suck
def available_os_memory
    require 'rbconfig'

    case RbConfig::CONFIG['host_os']
    when /darwin/
        `sysctl -n hw.memsize`.to_i / 1024 / 1024
    when /linux/
        `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024
    when /mswin|mingw|cygwin/
        `wmic computersystem Get TotalPhysicalMemory`.split[1].to_i / 1024 / 1024
    end
end
```
