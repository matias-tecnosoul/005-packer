Vagrant.configure("2") do |config|
  config.vm.box = "mw-ubuntu"
  
  # IMPORTANTE: Especificar usuario SSH
  config.ssh.username = "ubuntu"
  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 4
  end
end