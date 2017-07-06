export PATH="$PATH"
export EDITOR='nano'

BOLD="$(tput bold)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
MAGENTA="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
WHITE="$(tput setaf 7)"
RESET="$(tput sgr0)"
BG_RED="$(tput setab 1)"
BG_GREEN="$(tput setab 2)"
BG_YELLOW="$(tput setab 3)"
BG_BLUE="$(tput setab 4)"
BG_MAGENTA="$(tput setab 5)"
BG_CYAN="$(tput setab 6)"
BG_WHITE="$(tput setab 7)"

alias sudo='sudo '
alias editbash="nano $HOME/.bash_profile"
alias reloadbash="exec $SHELL -l"

reloadvhosts() {
  local vhost_dir=${1:-/var/www/vhosts}
  local conf_name=${2:-*dev.conf}
  local web_server=${3:-nginx}

  sudo find /etc/$web_server/sites-enabled/ -type l -exec rm {} \;
  sudo find $vhost_dir -name $conf_name -exec ln -sf {} /etc/$web_server/sites-enabled/ \;
  sudo service $web_server restart
}

export CLICOLOR=1
export PS1="${YELLOW}\u@\h${RESET} : ${BLUE}\w${RESET}\$(__git_ps1 ' : (%s)') \n\$ "
export PS2="${YELLOW}→${RESET} "
