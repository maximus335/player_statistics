# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.define 'player-statistics', primary: true do |dev|
    dev.vm.provider 'virtualbox' do |machine|
      machine.memory = 1024
      machine.cpus   = 1
    end

    dev.vm.box      = 'ubuntu/trusty64'
    dev.vm.hostname = 'player-statistics'

    dev.vm.network 'private_network', ip: '192.168.33.54'
    dev.vm.network 'forwarded_port', guest: 8080, host: 8080

    dev.ssh.forward_agent = true
    dev.vm.post_up_message =
      'Machine is up and ready. Use `vagrant ssh` to enter.'

    dev.vm.provision :shell, keep_color: true, inline: <<-INSTALL
      echo 'StrictHostKeyChecking no' > ~/.ssh/config
      echo 'UserKnownHostsFile=/dev/null' >> ~/.ssh/config
      sudo apt-get update -q
      sudo apt-get install git -y
    INSTALL

    dev.vm.provision :ansible_local do |ansible|
      ansible.provisioning_path = '/vagrant/ansible'
      ansible.playbook          = 'main.yml'
      ansible.inventory_path    = 'inventory.ini'
      ansible.verbose           = true
      ansible.limit             = 'local'
      ansible.galaxy_roles_path = 'roles'
      ansible.galaxy_role_file  = 'requirements.yml'
    end
  end
end