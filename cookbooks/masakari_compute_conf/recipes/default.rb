case node[:platform]
when 'ubuntu', 'debian'
  dpkg_package "hostmonitor_1.0.0-1_all" do
    source '/home/stack/masakari/hostmonitor_1.0.0-1_all.deb'
    action :install
  end

  dpkg_package "instancemonitor_1.0.0-1_all" do
    source '/home/stack/masakari/instancemonitor_1.0.0-1_all.deb'
    action :install
  end

  dpkg_package "processmonitor_1.0.0-1_all" do
    source '/home/stack/masakari/processmonitor_1.0.0-1_all.deb'
    action :install
  end
when 'redhat', 'centos'
  #TBD
  directory '/etc/hostmonitor' # fake
  directory '/etc/instancemonitor' # fake
  directory '/etc/processmonitor' # fake
end

template '/etc/hostmonitor/hostmonitor.conf' do
  source 'hostmonitor.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/instancemonitor/instancemonitor.conf' do
  source 'instancemonitor.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/processmonitor/processmonitor.conf' do
  source 'processmonitor.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
