#!/bin/bash

# to be run as user 'root'

echo 'RAILS_ENV=production' >> /etc/environment

adduser deploy --disabled-password --gecos ''
mkdir -p /home/deploy/.ssh
chown deploy:deploy /home/deploy/.ssh

echo "sudo vi /etc/sudoers # then add the line 'deploy  ALL=(ALL) NOPASSWD: ALL'"
