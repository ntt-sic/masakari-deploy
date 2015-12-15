
# temporal workaround code to avoid a bug in ubuntu 15.04 repo (vivid)
#   https://bugs.launchpad.net/ubuntu/+source/openhpi/+bug/1488453
case node[:platform]
when 'ubuntu'
  if node["platform_version"].to_f == 15.04
    remote_file '/root/libopenhpi2_2.14.1-1.3ubuntu2.1_amd64.deb' do
      source 'http://launchpadlibrarian.net/220534376/libopenhpi2_2.14.1-1.3ubuntu2.1_amd64.deb'
      owner 'root'
      group 'root'
      mode '0644'
      action :create_if_missing
    end
    remote_file '/root/openhpid_2.14.1-1.3ubuntu2.1_amd64.deb' do
      source 'http://launchpadlibrarian.net/220534378/openhpid_2.14.1-1.3ubuntu2.1_amd64.deb'
      owner 'root'
      group 'root'
      mode '0644'
      action :create_if_missing
    end
    dpkg_package "libopenhpi2_2.14.1-1.3ubuntu2.1" do
      source '/root/libopenhpi2_2.14.1-1.3ubuntu2.1_amd64.deb'
      action :install
    end
    dpkg_package "openhpid_2.14.1-1.3ubuntu2.1" do
      source '/root/openhpid_2.14.1-1.3ubuntu2.1_amd64.deb'
      action :install
    end
  end
end

%w{corosync pacemaker}.each do |pkg|
  package pkg do
    action :install
  end
end

case node[:platform]
when 'ubuntu', 'debian'
  template '/etc/default/corosync' do
    source 'corosync.erb'
    mode '0644'
    owner 'root'
    group 'root'
  end
when 'redhat', 'centos'
end

template '/etc/corosync/corosync.conf' do
  source 'corosync.conf.erb'
  mode '0644'
  owner 'root'
  group 'root'
end

%w{corosync pacemaker}.each do |pkg|
  service pkg do
    action [:enable, :start]
  end
end
