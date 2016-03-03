template '/home/stack/devstack/local.conf' do
  source 'local.conf.erb'
  mode '0644'
  owner 'stack'
  group 'stack'
end

case node[:platform]
when 'ubuntu', 'debian'
  %w{nfs-kernel-server}.each do |pkg|
    package pkg do
      action :install
    end
  end
when 'redhat', 'centos'
  %w{nfs-utils}.each do |pkg|
    package pkg do
      action :install
    end
  end
end

directory '/export' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory '/export/instances' do
  owner 'stack'
  group 'stack'
  mode '0755'
  action :create
end

template '/etc/exports' do
  source 'exports.erb'
  mode '0644'
  owner 'root'
  group 'root'
end

case node[:platform]
when 'ubuntu', 'debian'
  service 'nfs-kernel-server' do
    action [:enable, :start]
  end
when 'redhat', 'centos'
  service 'rpcbind' do
    action [:enable, :start]
  end
  service 'nfs-server' do
    action [:enable, :start]
  end
end

execute 'exportfs' do
  command 'exportfs -ra'
  action :run
end
