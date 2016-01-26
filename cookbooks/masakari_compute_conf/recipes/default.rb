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
  #TBD
  directory '/etc/masakari' # fake
end

template '/etc/masakari/masakari-hostmonitor.conf' do
  source 'hostmonitor.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/masakari/masakari-instancemonitor.conf' do
  source 'instancemonitor.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/masakari/masakari-processmonitor.conf' do
  source 'processmonitor.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
