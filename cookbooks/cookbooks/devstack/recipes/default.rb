%w{git}.each do |pkg|
  package pkg do
    action :install
  end
end

user "stack" do
  supports :manage_home => true
  comment 'devstack user'
  home '/home/stack'
  shell '/bin/bash'
  action :create
end

template "/etc/sudoers.d/stack" do
  source 'sudoers.d.stack.erb'
  mode '0440'
  owner 'root'
  group 'root'
end

git "/home/stack/devstack" do
  repository 'https://github.com/openstack-dev/devstack.git'
  ## use local repository
  #repository '/vagrant_openstack/devstack'
  revision 'stable/liberty'
  user 'stack'
  group 'stack'
  action :checkout
end

template '/home/stack/change-terminal-owner.sh' do
  source 'change-terminal-owner.sh.erb'
  mode '0755'
  owner 'stack'
  group 'stack'
end
