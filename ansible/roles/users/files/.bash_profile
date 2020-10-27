export PATH="$PATH:$HOME/.config/composer/vendor/bin"
export EDITOR="nano"
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
alias editshell="nano $HOME/.bash_profile"
alias reloadshell="exec $SHELL -l"
alias reload="reloadshell"

# Disable all Nginx website.
rmsites() {
  echo "Disabled sites: "
  sudo find /etc/nginx/sites-enabled/ -type l -printf ' - %p\n' -exec rm {} \;
}

# Enable Nginx websites
lnsites() {
  echo "Enabled sites: "
  sudo find "$PWD" -name "${1:-*dev.conf}" -printf ' - %p\n' -exec ln -sf {} /etc/nginx/sites-enabled/ \;
}

# Enable specified webserver and disable the others.
weben() {
    webservers=( nginx caddy )
    if [[ ! "${webservers[@]}" =~ "$1" ]]; then
        echo "Invalid webserver: '$1'"
        return 1
    fi

    for webserver in "${webservers[@]}"; do
        if [ "$webserver" = "$1" ]; then
            echo "Started $webserver"
            sudo service $webserver start
        else
            echo "Stopped $webserver"
            sudo service $webserver stop
        fi
    done

    return 0
}

# Create a new Laravel project.
laravel() {
    composer create-project --prefer-dist laravel/laravel $1
}

# Generate a self signed SSL certificate.
# https://stackoverflow.com/questions/43665243/invalid-self-signed-ssl-cert-subject-alternative-name-missing/43665244#43665244
# https://stackoverflow.com/questions/7580508/getting-chrome-to-accept-self-signed-localhost-certificate/43666288#43666288
# https://dev.to/techschoolguru/a-complete-overview-of-ssl-tls-and-its-cryptographic-system-36pd
# https://dev.to/techschoolguru/how-to-create-sign-ssl-tls-certificates-2aai
function genssl() {
    local domain="$1"
    local common="${2:-*.$domain}"
    local subject="/C=GB/ST=None/L=NB/O=None/CN=$common"
    local days=3560

    if [[ -z "$domain" ]]; then
        echo "Please supply a domain name";
        return 1
    fi

    if [[ -z "$common" ]]; then
        echo "Please supply a common name";
        return 1
    fi

    # Write out temporary configuration extfile.
    # https://www.cyberciti.biz/faq/using-heredoc-rediection-in-bash-shell-script-to-write-to-file/
    cat <<-EXT > v3.ext
    authorityKeyIdentifier=keyid,issuer
    basicConstraints=CA:FALSE
    keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
    subjectAltName = @alt_names
    
    [alt_names]
    DNS.1 = $common
    EXT

    openssl genrsa -out "$domain.key" 2048
    sudo openssl req -new -newkey rsa:2048 -sha256 -nodes -key "$domain.key" -subj "/C=GB/ST=None/L=NB/O=None/CN=$common" -out "$domain.csr"
    sudo openssl x509 -req -days $days -sha256 -in "$domain.csr" -signkey "$domain.key" -extfile v3.ext -out "$domain.crt"
    rm "$domain.csr" v3.ext

    echo ""
    echo "Apache2 Usage:"
    echo "SSLEngine On"
    echo "SSLCertificateFile    /etc/apache2/ssl/$domain.crt"
    echo "SSLCertificateKeyFile /etc/apache2/ssl/$domain.key"

    echo ""
    echo "Nginx Usage:"
    echo "ssl on;"
    echo "ssl_certificate     /etc/nginx/ssl/$domain.crt;"
    echo "ssl_certificate_key /etc/nginx/ssl/$domain.key;"
}

export CLICOLOR=1
export PS1="${YELLOW}\u@\h${RESET} : ${BLUE}\w${RESET}\$(__git_ps1 ' : (%s)') \n\$ "
export PS2="${YELLOW}→${RESET} "
