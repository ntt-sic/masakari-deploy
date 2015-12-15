case node[:platform]
when 'ubuntu', 'debian'
  dpkg_package "masakari_1.0.0-1_all" do
    source '/home/stack/masakari/masakari_1.0.0-1_all.deb'
    action :install
  end
when 'redhat', 'centos'
  # TBD
  directory '/etc/masakari' # fake
end

template '/etc/masakari/masakari.conf' do
  source 'masakari.conf.erb'
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
