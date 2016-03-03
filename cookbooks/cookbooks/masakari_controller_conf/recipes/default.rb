case node[:platform]
when 'ubuntu', 'debian'
  dpkg_package "masakari-controller_1.0.0-1_all" do
    source '/home/stack/masakari/masakari-controller_1.0.0-1_all.deb'
    action :install
  end
when 'redhat', 'centos'

  package ['python-setuptools', 'python-devel', 'mariadb-devel'] do
    action :install
  end

  execute "pip_installe_requirements" do
    cwd '/home/stack/masakari/masakari-controller'
    command 'pip install -r requirements.txt'
  end

  execute "python_installe" do
    cwd '/home/stack/masakari/masakari-controller'
    command 'python setup.py install'
  end
  template 'etc/systemd/system/masakari-controller.service' do
    source 'masakari-controller.service.erb'
    owner 'root'
    group 'root'
    mode '0644'
  end
  directory "/var/log/masakari" do
    owner "openstack"
    group "openstack"
    recursive true
    mode 0755
    action :create
    not_if { ::File.directory?("/var/log/masakari") }
  end
  directory "/etc/masakari" do
    owner "root"
    group "root"
    recursive true
    mode 0755
    action :create
    not_if { ::File.directory?("/etc/masakari") }
  end
end

template '/etc/masakari/masakari-controller.conf' do
  source 'masakari-controller.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/home/stack/masakari/masakari_database_setting.sh' do
  source 'masakari_database_setting.sh.erb'
  owner 'stack'
  group 'stack'
  mode '0755'
end

node[:masakari_controller_conf][:hostentrylist].each { |hash|
  hash.each { |host_name, host_ip|
    bash "insert_entry_to_hosts" do
      user "root"
      code <<-EOS
      echo "#{host_ip} #{host_name}" >> /etc/hosts
      EOS
      not_if "grep -q #{host_name} /etc/hosts"
    end
  }
}

template '/home/stack/masakari/reserved_host_add.sh' do
  source 'reserved_host_add.sh.erb'
  owner 'stack'
  group 'stack'
  mode '0755'
end

template '/home/stack/masakari/reserved_host_delete.sh' do
  source 'reserved_host_delete.sh.erb'
  owner 'stack'
  group 'stack'
  mode '0755'
end

template '/home/stack/masakari/reserved_host_list.sh' do
  source 'reserved_host_list.sh.erb'
  owner 'stack'
  group 'stack'
  mode '0755'
end

template '/home/stack/masakari/reserved_host_update.sh' do
  source 'reserved_host_update.sh.erb'
  owner 'stack'
  group 'stack'
  mode '0755'
end
