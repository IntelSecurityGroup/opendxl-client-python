#!/usr/bin/env bash

REQ_PY_VER="2.7.9"
REQ_SSL_VER="1.0.1"

PY_VER=$(python -c 'import sys; print(sys.version)')

### Install Python 2.7.9
if [[ "${PY_VER}" =~ "${REQ_PY_VER}" ]]; then
    echo "Already Version ${REQ_PY_VER}"
else
    sudo apt-get update
    sudo apt-get -y upgrade

    sudo echo 'deb http://httpredir.debian.org/debian jessie main' >> python-jessie.list
    sudo echo 'deb-src http://httpredir.debian.org/debian jessie main' >> python-jessie.list
    sudo echo 'deb http://httpredir.debian.org/debian jessie-updates main' >> python-jessie.list
    sudo echo 'deb-src http://httpredir.debian.org/debian jessie-updates main' >> python-jessie.list
    sudo echo 'deb http://security.debian.org/ jessie/updates main' >> python-jessie.list
    sudo echo 'deb-src http://security.debian.org/ jessie/updates main' >> python-jessie.list
    sudo mv python-jessie.list /etc/apt/sources.list.d/python-jessie.list

    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B48AD6246925553
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7638D0442B90D010
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9D6D8F6BC857C906

    sudo echo 'Package: *' >> python-jessie-pin
    sudo echo 'Pin: release o=Debian' >> python-jessie-pin
    sudo echo 'Pin-Priority: -10' >> python-jessie-pin
    sudo mv python-jessie-pin /etc/apt/preferences.d/python-jessie-pin

    sudo apt-get update
    sudo apt-get install -y -t jessie python2.7
fi

### Install Pip
echo "Installing Pip"
sudo apt-get install -y python-pip

### Install Open DXL Client
echo "Installing Open DXL Client"
cd /vagrant/
sudo python setup.py install

### Check OpenSSL
SSL_VER=$(python -c 'import ssl; print(ssl.OPENSSL_VERSION)')

if [[ "${SSL_VER}" =~ "${REQ_SSL_VER}" ]]; then
    echo "Already Version ${REQ_SSL_VER}"
else
    echo "Need OpenSSL version ${REQ_SSL_VER} or higher"
fi

## Setup Flask
## Use flask run --host=0.0.0.0 to start Flask
sudo pip install Flask
sudo echo 'export FLASK_APP=/vagrant/examples/tie/tie_rep_api.py' >> /etc/bash.bashrc