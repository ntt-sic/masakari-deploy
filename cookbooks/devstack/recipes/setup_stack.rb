execute "stack.sh" do
    cwd "/home/stack/devstack"
    user "stack"
    action :run
    environment ({'HOME' => '/home/stack/', 'USER' => 'stack'})
    command "/home/stack/devstack/stack.sh "
    timeout 7200
end
