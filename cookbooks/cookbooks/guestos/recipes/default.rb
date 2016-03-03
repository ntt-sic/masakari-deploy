## use local repository
#template "/etc/apt/sources.list" do
#  source 'sources.list.erb'
#  mode '0644'
#  owner 'root'
#  group 'root'
#end

case node[:platform]
when 'ubuntu', 'debian'
  execute "apt-get" do
    command 'apt-get update'
  end
when 'redhat', 'centos'
end

# to stop locale warning at login
case node[:platform]
when 'ubuntu', 'debian'
  %w{language-pack-en language-pack-ja}.each do |pkg|
    package pkg do
      action :install
    end
  end
  execute "update-locale-ctype" do
    command 'sudo update-locale LC_CTYPE=en_US.UTF-8'
  end
  execute "update-locale-all" do
    command 'sudo update-locale LC_ALL=en_US.UTF-8'
  end
when 'redhat', 'centos'
  template "/etc/environment" do
    source 'environment.erb'
    mode '0644'
    owner 'root'
    group 'root'
  end
end

## Disable centos firewall and iptables
case node[:platform]
when 'redhat', 'centos'
  service 'iptables.service' do
    action [:stop, :disable]
  end
  service 'firewalld' do
    action [:stop, :disable]
  end
end

## Add epel repo to centos
case node[:platform]
when 'redhat', 'centos'
  %w{yum-utils centos-release-openstack-liberty epel-release}.each do |pkg|
    package pkg do
      action :install
    end
  end
  execute "enable-epel" do
    command 'sudo yum-config-manager --enable epel'
  end
end
