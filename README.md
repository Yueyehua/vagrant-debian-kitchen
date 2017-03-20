debian-kitchen
==============

This is a Debian Jessie vagrant box with a functionnal systemd and
test-kitchen.
Puppet, Chef and Ansible are also installed in order to work with kitchen
for test purpose.

Prerequisites
-------------

- Vagrant
- Virtualbox
- Linux-headers

Usage
-----

```text
vagrant box add yueyehua/debian-kitchen
vagrant up yueyehua/debian-kitchen
vagrant ssh
[Do something here]
vagrant halt
vagrant destroy
```
