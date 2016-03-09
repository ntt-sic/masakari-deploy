git "/home/stack/masakari" do
  repository node[:masakari_ci_conf][:masakari_git]
  revision node[:masakari_ci_conf][:masakari_branch]
  user 'stack'
  group 'stack'
  action :sync
end

user "openstack" do
  supports :manage_home => true
  comment 'required by masakari'
  home '/home/openstack'
  shell '/bin/bash'
  action :create
end

template "/etc/sudoers.d/openstack" do
  source 'sudoers.d.openstack.erb'
  mode '0440'
  owner 'root'
  group 'root'
end

case node[:platform]
when 'ubuntu', 'debian'
  %w{git python-daemon dpkg-dev debhelper}.each do |pkg|
    package pkg do
      action :install
    end
  end

  # In "execute" resource,
  # "creates" propertie prevent a command from
  # creating a file when that file already exists.
  # Since, in ci we need to re-create debs,
  # comment out the creates

  execute "masakari-controller_1.0.0-1_all.deb" do
    command 'sudo ./debian/rules binary'
    cwd '/home/stack/masakari/masakari-controller'
    #creates '/home/stack/masakari/masakari-controller_1.0.0-1_all.deb'
  end

  execute "masakari-hostmonitor_1.0.0-1_all.deb" do
    command 'sudo ./debian/rules binary'
    cwd '/home/stack/masakari/masakari-hostmonitor'
    #creates '/home/stack/masakari/masakari-hostmonitor_1.0.0-1_all.deb'
  end

  execute "masakari-instancemonitor_1.0.0-1_all.deb" do
    command 'sudo ./debian/rules binary'
    cwd '/home/stack/masakari/masakari-instancemonitor'
    #creates '/home/stack/masakari/masakari-instancemonitor_1.0.0-1_all.deb'
  end

  execute "masakari-processmonitor_1.0.0-1_all.deb" do
    command 'sudo ./debian/rules binary'
    cwd '/home/stack/masakari/masakari-processmonitor'
    #creates '/home/stack/masakari/masakari-processmonitor_1.0.0-1_all.deb'
  end

when 'redhat', 'centos'
  %w{git python-daemon rpm-build rpmdevtools python-pip}.each do |pkg|
    package pkg do
      action :install
    end
  end
  template '/home/stack/masakari/make_rpm_all.sh' do
    source 'make_rpm_all.sh.erb'
    owner 'stack'
    group 'stack'
    mode '0755'
  end
  execute "masakari-controller_1.0.0-1_all.deb" do
    command 'bash make_rpm_all.sh'
    cwd '/home/stack/masakari'
  end
end
