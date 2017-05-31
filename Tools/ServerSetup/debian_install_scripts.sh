#!/bin/bash

# INSTALLATION SCRIPT FOR:
#
# Linux 3.16.0-4-amd64 x86_64
#
# PRETTY_NAME="Debian GNU/Linux 8 (jessie)"
# NAME="Debian GNU/Linux"
# VERSION_ID="8"
# VERSION="8 (jessie)"
# ID=debian

uname -srm
cat /etc/*-release

# SSH Authentication by Password - yes
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
service sshd restart

# VERSIONS

NODE_VERSION=7
SPHINX_VERSION=2.2.11-release-1

DEPLOYER_RVM_RUBY_VERSION=ruby-2.3.3
DEPLOYER_RVM_GEMSET_NAME=rails_app

# DEFINE PASSWORDS

ROOT_PASSWORD=`openssl rand -hex 15`
DEPLOYER_PASSWORD=`openssl rand -hex 15`

ROOT_MYSQL_PASSWORD=`openssl rand -hex 15`
DEPLOYER_MYSQL_PASSWORD=`openssl rand -hex 15`

ROOT_PSQL_PASSWORD=`openssl rand -hex 15`
DEPLOYER_PSQL_PASSWORD=`openssl rand -hex 15`

# SET LANG VARS

echo 'export LC_ALL="en_US.UTF-8"'   >> ~/.bashrc
echo 'export LANGUAGE="en_US:en"'    >> ~/.bashrc
echo 'export LANG="en_US.UTF-8"'     >> ~/.bashrc
echo 'export LC_CTYPE="en_US.UTF-8"' >> ~/.bashrc

source ~/.bashrc

# VIM OPTIONS

echo "set nocompatible" > ~/.vimrc
echo ":set backspace=indent,eol,start" >> ~/.vimrc

# APT UPDATE AND CORE UTILS

mv /etc/apt/sources.list /etc/apt/sources.list.backup

echo "deb http://httpredir.debian.org/debian/ stable main contrib non-free
deb http://httpredir.debian.org/debian/ stable-updates main contrib non-free
deb http://security.debian.org/ stable/updates main contrib non-free
deb-src http://httpredir.debian.org/debian/ stable main contrib non-free
deb-src http://httpredir.debian.org/debian/ stable-updates main contrib non-free
deb-src http://security.debian.org/ stable/updates main contrib non-free
deb http://httpredir.debian.org/debian jessie-backports main contrib non-free
deb-src http://httpredir.debian.org/debian jessie-backports main contrib non-free
" > /etc/apt/sources.list

# ALT WAY
# wget http://debian.mirror.vu.lt/debian-sources.list && mv debian-sources.list /etc/apt/sources.list

apt-get clean
apt-get update && apt-get install -y coreutils

##################################################################
# `ROOT` USER
##################################################################

echo "root:$ROOT_PASSWORD" | chpasswd

##################################################################
# `RAILS` USER
##################################################################

adduser rails --home /home/rails --shell /bin/bash --disabled-password --gecos ''
echo "rails:$DEPLOYER_PASSWORD" | chpasswd
chown -R rails:rails /home/rails/

# FOR SSH

mkdir -p /home/rails/.ssh
chown rails:rails /home/rails/.ssh
chmod 0700 /home/rails/.ssh

# FOR NGINX

mkdir -p /home/rails/www
chown rails:rails /home/rails/www
chmod 0755 /home/rails/www

# FOR GEM INSTALL

echo 'gem: --no-document' >> /home/rails/.gemrc
chown rails:rails /home/rails/.gemrc
chmod -R 0644 /home/rails/.gemrc

# FOR VIM

echo "set nocompatible" >> /home/rails/.vimrc
echo ":set backspace=indent,eol,start" >> /home/rails/.vimrc
chown rails:rails /home/rails/.vimrc
chmod 0644 /home/rails/.vimrc

##################################################################
# `RAILS` USER
##################################################################

# CREATE SWAP

dd if=/dev/zero of=/swapfile bs=1024 count=2048k
chmod 0600 /swapfile
mkswap /swapfile
swapon /swapfile

echo "/swapfile none swap sw 0 0" >> /etc/fstab

echo 10 | tee /proc/sys/vm/swappiness
echo vm.swappiness = 10 | tee -a /etc/sysctl.conf
sysctl --system

# MINIMAL SOFT PACK

apt-get install -y sudo screen dialog apt-transport-https ca-certificates \
  man-db deborphan aptitude bc bash-completion command-not-found \
  python-software-properties htop nmon iotop dstat vnstat unzip zip unar pigz \
  p7zip-full logrotate wget curl w3m lftp rsync openssh-server telnet nano mc \
  pv less sysstat ncdu ethtool dnsutils mtr-tiny rkhunter ntpdate ntp vim tree

# REQUIREMENTS LIBS

apt-get install -y build-essential autoconf bison checkinstall git-core \
  libodbc1 libc6-dev libreadline6 libreadline6-dev libsqlite3-0 libsqlite3-dev \
  libssl-dev libxml2 libxml2-dev libxslt-dev libxslt1-dev libxslt1.1 \
  libyaml-dev openssl sqlite3 zlib1g zlib1g-dev

# NEW RELIC MONITOR

echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | tee /etc/apt/sources.list.d/newrelic.list
wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -
apt-get update
apt-get install -y newrelic-sysmond

### LETS ENCRIPT

apt-get install -y letsencrypt -t jessie-backports

# NODE
# https://github.com/nodesource/distributions

curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -
apt-get install -y nodejs

# YARN

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

apt-get update
apt-get install -y yarn

# IMAGE OPTIMIZERS

apt-get install -y advancecomp gifsicle jhead jpegoptim libjpeg-progs optipng pngquant

# PNGCRUSH. SEE FAILED BINS LIST
# http://www.rubydoc.info/gems/image_optim/ImageOptim/BinResolver/Bin
cd /tmp/

wget https://netcologne.dl.sourceforge.net/project/pmt/pngcrush/1.8.11/pngcrush-1.8.11.tar.gz
tar -xvf pngcrush-1.8.11.tar.gz
cd pngcrush-1.8.11
make pngcrush
cp /tmp/pngcrush-1.8.11/pngcrush /usr/local/bin/pngcrush

rm -rf ./pngcrush-1.8.11
cd ~

# PNGOUT
cd /tmp/

wget http://static.jonof.id.au/dl/kenutils/pngout-20150319-linux.tar.gz
tar -xvf pngout-20150319-linux.tar.gz
cp /tmp/pngout-20150319-linux/x86_64/pngout /usr/local/bin/pngout

rm -rf ./pngout-20150319*
cd ~

# SVGO
npm install -g svgo

# IMAGE MAGICK

apt-get install -y imagemagick libmagickwand-dev
convert --version

# REDIS

apt-get install -y redis-server

# NGINX

curl http://nginx.org/keys/nginx_signing.key | apt-key add -

echo 'deb http://nginx.org/packages/debian/ jessie nginx'     >> /etc/apt/sources.list.d/nginx.list
echo 'deb-src http://nginx.org/packages/debian/ jessie nginx' >> /etc/apt/sources.list.d/nginx.list

apt-get update
apt-get install -y nginx

# PYTHON / PIP / PYGMENTS

apt-get install -y python-pip
pip install --upgrade Pygments

# MYSQL

export DEBIAN_FRONTEND=noninteractive

debconf-set-selections <<< "mysql-server mysql-server/root_password password $ROOT_MYSQL_PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $ROOT_MYSQL_PASSWORD"

apt-get install -y mysql-server mysql-common mysql-client libmysqlclient-dev ruby-mysql

unset DEBIAN_FRONTEND

echo "[client]
user=root
password=$ROOT_MYSQL_PASSWORD
" >> ~/.my.cnf

chmod 600 ~/.my.cnf

mysql -D mysql -r -B -N -e "CREATE USER 'rails'@'localhost' IDENTIFIED BY '$DEPLOYER_MYSQL_PASSWORD'"
mysql -D mysql -r -B -N -e "CREATE DATABASE rails_app_db CHARACTER SET utf8 COLLATE utf8_general_ci;"
mysql -D mysql -r -B -N -e "GRANT ALL PRIVILEGES ON rails_app_db.* TO 'rails'@'localhost' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0"
mysql -D mysql -r -B -N -e "SHOW GRANTS FOR 'rails'@'localhost'"

# PSQL

# apt-cache pkgnames postgresql
apt-get install -y postgresql libpq-dev

su -s /bin/bash -l postgres -c "psql -U postgres -c \"CREATE USER rails WITH PASSWORD '$DEPLOYER_PSQL_PASSWORD';\""
su -s /bin/bash -l postgres -c "psql -U postgres -c \"ALTER ROLE rails WITH CREATEDB;\""

su -s /bin/bash -l postgres -c "createdb -E UTF8 -O rails rails_app_db"
su -s /bin/bash -l postgres -c "psql -U postgres -c \"GRANT ALL PRIVILEGES ON DATABASE rails_app_db TO rails;\""

# SPHINX SEARCH

cd /tmp

wget http://sphinxsearch.com/files/sphinxsearch_$SPHINX_VERSION~jessie_amd64.deb
dpkg -i sphinxsearch_$SPHINX_VERSION~jessie_amd64.deb
rm -rf ./sphinxsearch*
cd ~

# RVM REQUIREMENTS

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

\curl -sSL https://get.rvm.io | bash
/usr/local/rvm/bin/rvm requirements

(echo 'yes') | (/usr/local/rvm/bin/rvm implode)

### RAILS USER ###

su -s /bin/bash -l rails -c "echo 'export LC_ALL=\"en_US.UTF-8\"'   >> ~/.bashrc"
su -s /bin/bash -l rails -c "echo 'export LANGUAGE=\"en_US:en\"'    >> ~/.bashrc"
su -s /bin/bash -l rails -c "echo 'export LANG=\"en_US.UTF-8\"'     >> ~/.bashrc"
su -s /bin/bash -l rails -c "echo 'export LC_CTYPE=\"en_US.UTF-8\"' >> ~/.bashrc"
su -s /bin/bash -l rails -c "source ~/.bashrc"

su -s /bin/bash -l rails -c "\curl -sSL https://get.rvm.io | bash"
su -s /bin/bash -l rails -c "source ~/.bash_profile"
su -s /bin/bash -l rails -c "which rvm"
su -s /bin/bash -l rails -c "rvm autolibs disable & rvm install $DEPLOYER_RVM_RUBY_VERSION"
su -s /bin/bash -l rails -c "(rvm use $DEPLOYER_RVM_RUBY_VERSION) && (rvm gemset use $DEPLOYER_RVM_GEMSET_NAME --create)"
su -s /bin/bash -l rails -c "rvm $DEPLOYER_RVM_RUBY_VERSION@$DEPLOYER_RVM_GEMSET_NAME do gem install bundler"

echo "--------------------------------------------------" >> ~/credentials.txt
echo "ROOT CREDENTIALS"                                   >> ~/credentials.txt
echo "--------------------------------------------------" >> ~/credentials.txt

echo "
DROPLET:
  username: root
  password: $ROOT_PASSWORD

POSTGRESQL
  username: root
  password: $ROOT_PSQL_PASSWORD

MYSQL
  username: root
  password: $ROOT_MYSQL_PASSWORD
" >> ~/credentials.txt

echo "--------------------------------------------------" >> /home/rails/credentials.txt
echo "DEPLOYER LOGIN/PASSWORD"                            >> /home/rails/credentials.txt
echo "--------------------------------------------------" >> /home/rails/credentials.txt

echo "
LOGIN: rails
PASSWORD: $DEPLOYER_PASSWORD
"  >> /home/rails/credentials.txt

echo "--------------------------------------------------" >> /home/rails/credentials.txt
echo "PSQL DATABASE CONNECTION PARAMS"                    >> /home/rails/credentials.txt
echo "--------------------------------------------------" >> /home/rails/credentials.txt

echo "
production:
  adapter: postgresql
  encoding: unicode
  pool: 5
  username: rails
  database: rails_app_db
  password: $DEPLOYER_PSQL_PASSWORD
" >> /home/rails/credentials.txt

echo "--------------------------------------------------" >> /home/rails/credentials.txt
echo "MYSQL DATABASE CONNECTION PARAMS"                   >> /home/rails/credentials.txt
echo "--------------------------------------------------" >> /home/rails/credentials.txt

echo "
production:
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: rails
  database: rails_app_db
  password: $DEPLOYER_MYSQL_PASSWORD
"  >> /home/rails/credentials.txt

echo "--------------------------------------------------" >> /home/rails/credentials.txt
echo "SERVER IP ADDRESS PARAMS"                           >> /home/rails/credentials.txt
echo "--------------------------------------------------" >> /home/rails/credentials.txt

echo "" >> /home/rails/credentials.txt

ifconfig eth0 | grep inet | awk "{print $2}" | sed "s/addr://" >> /home/rails/credentials.txt

cat ~/credentials.txt
cat /home/rails/credentials.txt

# NOTES:
# checkinstall -y
