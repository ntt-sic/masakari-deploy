case node[:platform]
when 'ubuntu', 'debian'
  package ['build-essential', 'python-dev', 'python-pip', 'libmysqlclient-dev', 'libffi-dev', 'libssl-dev'] do
    action :install
  end
  execute "upgrade pip" do
    command "pip install -U pip"
    user "root"
  end
  execute "masakari requirements" do
    command "pip install -r requirements.txt"
    cwd "/home/stack/masakari/masakari-controller/"
    user "root"
    environment 'PATH' => "/usr/local/bin:#{ENV['PATH']}"
  end
  dpkg_package "masakari-controller_1.0.0-1_all" do
    source '/home/stack/masakari/masakari-controller_1.0.0-1_all.deb'
    action :install
  end
when 'redhat', 'centos'
  package ['python-setuptools', 'python-devel', 'mariadb-devel', 'python-pip', 'libffi-devel', 'openssl-devel'] do
    action :install
  end
  execute "upgrade pip" do
    command "pip install -U pip"
    user "root"
  end
  execute "masakari requirements" do
    command "pip install -r requirements.txt"
    cwd "/home/stack/masakari/masakari-controller/"
    user "root"
    environment 'PATH' => "/usr/local/bin:#{ENV['PATH']}"
  end
  rpm_package "masakari-controller-1.0.0-1.x86_64" do
    source "/home/stack/masakari/masakari-controller-1.0.0-1.x86_64.rpm"
    action :install
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
