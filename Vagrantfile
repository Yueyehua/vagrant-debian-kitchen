require 'yaml'
user_config = YAML.load_file 'config.yml'

Vagrant.configure(2) do |config|
  config.vm.box = 'debian/jessie64'
  config.vm.network 'private_network', ip: '172.16.100.2'

  config.vm.define 'debian-kitchen'

  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.name = 'debian-kitchen'
    vb.memory = user_config['vm_memory']
    vb.customize [
      'modifyvm', :id,
      '--cableconnected1', 'on'
    ]
  end

  config.vm.provision 'shell' do |s|
    s.path = 'provision/setup.sh'
  end

  config.push.define 'atlas' do |push|
    push.app = 'yueyehua/debian-kitchen'
    push.vcs = false
  end
end
