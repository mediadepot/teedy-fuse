Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    v.name = "teedy_builder"
    v.memory = 16384
    v.cpus = 6
  end

  # install fuse on centos.
  config.vm.provision "shell",
      inline: "sudo yum install -y fuse* afuse && sudo modprobe fuse"

  # build & run docker container.
  config.vm.provision "docker" do |d|
    d.build_image "/vagrant/", args: '-t "mediadepot/teedy-fuse"'
    d.run "mediadepot/teedy-fuse", args: '--privileged=true'
  end
end
