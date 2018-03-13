# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Work behind proxy?
  # source: https://github.com/tmatilai/vagrant-proxyconf
  # First, install the plugin:
  # $vagrant plugin install vagrant-proxyconf
  # then uncomment following section and set your proxy server
  # Note:
  # In no_proxy, for some reason IP range regex does not work.
  # Therefore, put all the no_proxy IPs in config.proxy.no_proxy list.
  # if Vagrant.has_plugin?("vagrant-proxyconf")
  #   config.proxy.http     = "YOUR-HTTP-PROXY-SERVER"
  #   config.proxy.https    = "YOUR-HTTPS-PROXY-SERVER"
  #   config.proxy.no_proxy = "localhost,127.0.0.1,192.168.50.1,192.168.50.10,192.168.50.11,192.168.50.12"
  # end
  # Recommended plugins
  # This will install required additions to gust VM
  # vagrant plugin install vagrant-vbguest

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  #config.vm.box = "base"
  config.vm.box = "ubuntu/trusty64"
  # Select centos/7 box to build masakari with centOS 7
  # config.vm.box = "centos/7"
  # WIP, experimental: ubuntu/vivid64
  #config.vm.box = "ubuntu/vivid64"
  # WIP, experimental: centos/7
  #config.vm.box = "centos/7"

  # vagrant-vbguest plugin option
  #config.vbguest.auto_update = false

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  ##config.vm.synced_folder "../openstack", "/vagrant_openstack"
  ##config.vm.synced_folder "../ubuntu_mirror", "/vagrant_ubuntu_mirror"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with CFEngine. CFEngine Community packages are
  # automatically installed. For example, configure the host as a
  # policy server and optionally a policy file to run:
  #
  # config.vm.provision "cfengine" do |cf|
  #   cf.am_policy_hub = true
  #   # cf.run_file = "motd.cf"
  # end
  #
  # You can also configure and bootstrap a client to an existing
  # policy server:
  #
  # config.vm.provision "cfengine" do |cf|
  #   cf.policy_server_address = "10.0.2.15"
  # end

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file default.pp in the manifests_path directory.
  #
  # config.vm.provision "puppet" do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "default.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision "chef_solo" do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { mysql_password: "foo" }
  # end
  #config.vm.provision "chef_solo" do |chef|
  #  chef.json = {
  #  }
  #end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision "chef_client" do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"

  # Use masakari_ci_conf section to get masakari source from custom source.
  # "masakari_git" : Repo to clone masakari source
  #                  default is https://github.com/ntt-sic/masakari.git
  # "masakari_branch" : Branch to checkout in above repo
  #                     default is master
  # Here is a sample for controller
  # chef.json = {
  #     "controller_conf" => {
  #       "host_ip" => "192.168.50.10",
  #       "service_host" => "192.168.50.10"
  #     },
  #     "masakari_controller_conf" => {
  #       "hostentrylist" => [
  #                           { "compute1" => "192.168.50.11" },
  #                           { "compute2" => "192.168.50.12" }
  #                          ]
  #     },
  #     "masakari_ci_conf" => {
  #       "masakari_git" => "https://github.com/ntt-sic/masakari.git",
  #       "masakari_branch" => "masater"
  #     }
  #   }



  # Definition of Controller node
  config.vm.define "controller" do |controller|
    controller.vm.hostname = "controller"
    controller.vm.network "private_network", ip: "192.168.50.10"
    controller.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "8192", "--cpus", "4", "--ioapic", "on"]
    end
    controller.vm.provision "chef_solo" do |chef|
      # run vagrant as
      #$CHEF_LOG=debug vagrant provision
      chef.log_level = ENV.fetch("CHEF_LOG", "info").downcase.to_sym
      # Log format
      # Valid formats are doc, min (or minimal), and null.
      # Chef uses doc by default when you run it directly from the command line.
      # Vagrant, on the other hand, applies null by default
      chef.formatter = ENV.fetch("CHEF_FORMAT", "null").downcase.to_sym
      chef.arguments = '-l debug --legacy-mode'
      chef.roles_path = "roles"
      chef.add_role("controller")
      chef.json = {
        "controller_conf" => {
          "host_ip" => "192.168.50.10",
          "service_host" => "192.168.50.10"
        },
        "masakari_controller_conf" => {
          "hostentrylist" => [
            { "compute1" => "192.168.50.11" },
            { "compute2" => "192.168.50.12" }
          ]
        }
      }
    end
  end

  # Definition of Compute node No.1
  config.vm.define "compute1" do |compute1|
    compute1.vm.hostname = "compute1"
    compute1.vm.network "private_network", ip: "192.168.50.11"
    compute1.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "1", "--ioapic", "on"]
    end
    compute1.vm.provision "chef_solo" do |chef|
      chef.log_level = ENV.fetch("CHEF_LOG", "info").downcase.to_sym
      chef.formatter = ENV.fetch("CHEF_FORMAT", "null").downcase.to_sym
      chef.arguments = '-l debug --legacy-mode'
      chef.roles_path = "roles"
      chef.add_role("compute")
      chef.json = {
        "pacemaker" => {
          "bindnetaddr" => "192.168.50.0",
          "nodelist" => ['192.168.50.11','192.168.50.12']
        },
        "compute_conf" => {
          "host_ip" => "192.168.50.11",
          "service_host" => "192.168.50.10"
        }
      }
    end
  end

  # Definition of Compute node No.2
  config.vm.define "compute2" do |compute2|
    compute2.vm.hostname = "compute2"
    compute2.vm.network "private_network", ip: "192.168.50.12"
    compute2.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "1", "--ioapic", "on"]
    end
    compute2.vm.provision "chef_solo" do |chef|
      chef.log_level = ENV.fetch("CHEF_LOG", "info").downcase.to_sym
      chef.formatter = ENV.fetch("CHEF_FORMAT", "null").downcase.to_sym
      chef.arguments = '-l debug --legacy-mode'
      chef.roles_path = "roles"
      chef.add_role("compute")
      chef.json = {
        "pacemaker" => {
          "bindnetaddr" => "192.168.50.0",
          "nodelist" => ['192.168.50.11','192.168.50.12']
        },
        "compute_conf" => {
          "host_ip" => "192.168.50.12",
          "service_host" => "192.168.50.10"
        }
      }
    end
  end

end
