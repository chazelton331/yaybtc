#!/bin/bash

# to be run as user 'deploy'
# copy files:
#     sshd_config, rails-logrotate, nginx_app
# to the server as deploy (so they're in /home/deploy)

echo 'export VISUAL=vi' >> .profile
source .profile

echo "manually add your key to /home/deploy/.ssh/authorized_keys"

touch /home/deploy/.ssh/authorized_keys
sudo chown deploy:deploy /home/deploy/.ssh/authorized_keys
sudo chmod 0600 /home/deploy/.ssh/authorized_keys

sudo apt-get -y install software-properties-common
sudo apt-get -y install python-software-properties
sudo apt-get -y update
sudo apt-get -y install sysv-rc-conf \
                        curl \
                        build-essential \
                        openssl \
                        libreadline6 \
                        libreadline6-dev \
                        git-core \
                        zlib1g \
                        zlib1g-dev \
                        libssl-dev \
                        libyaml-dev \
                        libsqlite3-dev \
                        sqlite3 \
                        libxml2-dev \
                        libxslt-dev \
                        autoconf \
                        libc6-dev \
                        ncurses-dev \
                        automake \
                        libtool \
                        bison \
                        subversion \
                        pkg-config \
                        nginx \
                        nodejs \
                        ntp \
                        libcurl4-gnutls-dev

sudo mv /home/deploy/sshd_config /etc/ssh/sshd_config
sudo service ssh restart

\curl -L https://get.rvm.io | bash -s stable --autolibs=enabled --ruby=2.4.0
source ~/.rvm/scripts/rvm

sudo mv rails-logrotate /etc/logrotate.d/

sudo apt-get -y install postgresql-9.3 postgresql-server-dev-9.3

sudo apt-get install pgtune
pgtune -i /etc/postgresql/9.3/main/postgresql.conf -o /tmp/postgresql.conf.new
sudo mv /tmp/postgresql.conf.new /etc/postgresql/9.3/main/postgresql.conf.new
sudo mv /etc/postgresql/9.3/main/postgresql.conf /etc/postgresql/9.3/main/postgresql.conf.old
sudo mv /etc/postgresql/9.3/main/postgresql.conf.new /etc/postgresql/9.3/main/postgresql.conf
sudo chmod 0644 /etc/postgresql/9.3/main/postgresql.conf

sudo service postgresql start

echo "Edit /etc/sysctl.conf and set an appropriate value for kernel.shmmax"
echo "# if you try to start postgresql and it fails, look for this error message:"
echo "#   Failed system call was shmget(key=5432001, size=974528512, 03600)."
echo "# if you see this, add the line"
echo "#   kernel.shmmax = 999000000 # or some higher number"
echo "# then run"
echo "sudo sysctl -p"
echo "sudo service postgresql restart"

sudo su - postgres -c "createuser -d -R -S deploy"
createdb yaybtc_production

sudo sysv-rc-conf postgresql on

sudo cp nginx_app  /etc/nginx/sites-available/app
sudo cp nginx_http /etc/nginx/sites-available/http
sudo rm /etc/nginx/sites-available/default
sudo ln -s /etc/nginx/sites-available/app /etc/nginx/sites-enabled/app
sudo ln -s /etc/nginx/sites-available/http /etc/nginx/sites-enabled/http
sudo /etc/init.d/nginx start

echo "To set up SSL install your ssl.cert and ssl.key files and restart nginx"
echo "sudo mkdir -p /data/ssl"
echo "sudo mv ssl.* /data/ssl/ # ssl.cert and ssl.key"
echo "sudo chown deploy:deploy /data/ssl -R"
echo "sudo /etc/init.d/nginx reload"
echo "sudo /etc/init.d/nginx restart"
