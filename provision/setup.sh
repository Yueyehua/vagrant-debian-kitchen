#!/bin/bash

APT_GET_CMD='/usr/bin/apt-get -qq'

echo 'debian-kitchen' > /etc/hostname

echo 'Provisioning virtual machine...'

# Apt update and install dependencies
$APT_GET_CMD update && $APT_GET_CMD -y dist-upgrade;
$APT_GET_CMD -y install iproute sudo less vim nano tree curl git autoconf bison \
  build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev \
  libncurses5-dev libffi-dev libgdbm3 libgdbm-dev apt-transport-https \
  ca-certificates software-properties-common;

# Install Ruby 2.4.0
_RUBY='ruby-2.4.0'
_RUBY_VERS='2.4'
pushd /tmp;
curl "https://cache.ruby-lang.org/pub/ruby/${_RUBY_VERS}/${_RUBY}.tar.gz" | \
  tar xzf -;
pushd /tmp/${_RUBY};
./configure \
  --enable-shared \
  --disable-install-doc \
  --disable-install-rdoc \
  --disable-install-capi > /dev/null;
make -j > /dev/null && make install > /dev/null;
popd; popd;
rm -rf /tmp/${_RUBY};

# Install Python 3
$APT_GET_CMD -y install python3 python3-pip;

# Install docker, vagrant, chef, puppet and ansible with lint tools
curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -;
add-apt-repository \
  "deb https://apt.dockerproject.org/repo/ debian-jessie main";
add-apt-repository \
  "deb http://httpredir.debian.org/debian/ jessie main contrib";
$APT_GET_CMD update && \
$APT_GET_CMD -y install docker-engine virtualbox vagrant puppet puppet-lint;
gem install -q --no-rdoc --no-ri --no-format-executable --no-user-install \
  chef-dk foodcritic rubocop yaml-lint travis;
pip3 install ansible ansible-lint pylint;

# Install other tools for test purpose
$APT_GET_CMD -y install snmp traceroute nmap

# Clean all
$APT_GET_CMD clean autoclean;

# Install gems
gem install -q --no-rdoc --no-ri --no-format-executable --no-user-install \
  berkshelf bundler busser busser-serverspec serverspec webmock;

# Install test-kitchen
gem install -q --no-rdoc --no-ri --no-format-executable --no-user-install \
  test-kitchen \
  kitchen-puppet \
  kitchen-ansible \
  kitchen-docker_cli;

echo 'Virtual machine is now provisioned.';

exit 0;
