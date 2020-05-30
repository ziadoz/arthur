export PATH="$PATH:/usr/local/go/bin"
export EDITOR='nano'
export CDPATH=".:$HOME:/var/www/vhosts"

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

rmsites() {
  echo "Disabled sites: "
  sudo find /etc/nginx/sites-enabled/ -type l -printf ' - %p\n' -exec rm {} \;
}

lnsite() {
  echo "Enabled sites: "
  sudo find "$PWD" -name "${1:-*dev.conf}" -printf ' - %p\n' -exec ln -sf {} /etc/nginx/sites-enabled/ \;
}

laravel() {
    composer create-project --prefer-dist laravel/laravel $1
}

export CLICOLOR=1
export PS1="${YELLOW}\u@\h${RESET} : ${BLUE}\w${RESET}\$(__git_ps1 ' : (%s)') \n\$ "
export PS2="${YELLOW}→${RESET} "
