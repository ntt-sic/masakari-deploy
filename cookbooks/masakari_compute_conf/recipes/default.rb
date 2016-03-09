case node[:platform]
when 'ubuntu', 'debian'
  dpkg_package "masakari-hostmonitor_1.0.0-1_all" do
    source '/home/stack/masakari/masakari-hostmonitor_1.0.0-1_all.deb'
    action :install
  end

  dpkg_package "masakari-instancemonitor_1.0.0-1_all" do
    source '/home/stack/masakari/masakari-instancemonitor_1.0.0-1_all.deb'
    action :install
  end

  dpkg_package "masakari-processmonitor_1.0.0-1_all" do
    source '/home/stack/masakari/masakari-processmonitor_1.0.0-1_all.deb'
    action :install
  end

when 'redhat', 'centos'
  package ['python-setuptools', 'python-devel'] do
    action :install
  end
  package ['libvirt', 'libvirt-python', 'libvirt-devel', 'net-tools'] do
    #option '--enablerepo=epel'
    action :install
  end

  # Red Hat has switched to use pcs (Pacemaker Configuration System)
  # crm now has its own repo
  # masakari-processmonitor need to fix. But in the meantime we gonna use
  # http://download.opensuse.org/repositories/network:\
  # /ha-clustering/CentOS_CentOS-6/network:ha-clustering.repo
  bash 'install_crmsh' do
  cwd '/home/stack/'
  code <<-EOH
    curl -O http://download.opensuse.org/repositories/network:/ha-clustering:/Stable/Fedora_22/network:ha-clustering:Stable.repo
    sudo mv network:ha-clustering:Stable.repo /etc/yum.repos.d/
    sudo yum -y install crmsh
    EOH
  end

  rpm_package "masakari-instancemonitor-1.0.0-1.x86_64" do
    source "/home/stack/masakari/masakari-instancemonitor-1.0.0-1.x86_64.rpm"
    action :install
  end

  rpm_package "masakari-hostmonitor-1.0.0-1.x86_64" do
    source "/home/stack/masakari/masakari-hostmonitor-1.0.0-1.x86_64.rpm"
    action :install
  end

  rpm_package "masakari-processmonitor-1.0.0-1.x86_64" do
    source "/home/stack/masakari/masakari-processmonitor-1.0.0-1.x86_64.rpm"
    action :install
  end
end

template '/etc/masakari/masakari-hostmonitor.conf' do
  source 'masakari-hostmonitor.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/masakari/masakari-instancemonitor.conf' do
  source 'masakari-instancemonitor.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/masakari/masakari-processmonitor.conf' do
  source 'masakari-processmonitor.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
