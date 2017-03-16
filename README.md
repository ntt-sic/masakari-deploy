# Vagrant project with devstack and Chef recipes for Masakari

## What is masakari-deploy ?
It contains Vagrantfile and chef recipes to deploy three VMs including OpenStack and Masakari. You will be able to test and demonstrate the way how Masakari works on your laptop.

## How to use ?

### Prerequisites
* vagrant
* vagrant box of ubuntu/trusty64 (or centos/7 for cent OS)

  For Ubuntu,
  ```sh
  $ vagrant box add ubuntu/trusty64
  ```
  For CentOS,
  ```sh
  $ vagrant box add centos/7
  ```
### Deployment
* creating three VMs consisting of Controller, Compute1 and Compute2.

   Default Vagrant file use the ubuntu/trusty64 box.

   Change config.vm.box = "centos/7" to build masakari with centOS.

   To successfully build centos environment,
   you might need to install vagrant-vbguest plugin

   ```sh
   $ vagrant plugin install vagrant-vbguest
   ```

   ```sh
   $ vagrant up
   $ vagrant status
   Current machine states:

   controller                running (virtualbox)
   compute1                  running (virtualbox)
   compute2                  running (virtualbox)
   ```
* deploy OpenStack in Controller

  ```sh
  $ vagrant ssh controller
  vagrant@controller:~$ sudo -i
  root@controller:~# su - stack
  stack@controller:~$ cd devstack/
  stack@controller:~/devstack$ ./stack.sh
  ```
* prepare masakari-controller database in Controller

  ```sh
  stack@controller:~/devstack$ cd ~/masakari/
  stack@controller:~/masakari$ ./masakari_database_setting.sh
  ```
* start masakari-controller in Controller

  In Ubuntu,

  ```sh
  stack@controller:~/masakari$ sudo service masakari-controller start
  ```
  In CentOS,

  ```sh
  stack@compute1:~/devstack$ sudo systemctl enable masakari-controller.service
  ```
  * deploy OpenStack in Compute1 and Compute2 (execute respectively)

  ```sh
  $ vagrant ssh compute1
  vagrant@compute1:~$ sudo -i
  root@compute1:~# su - stack
  stack@compute1:~$ cd devstack/
  stack@compute1:~/devstack$ ./stack.sh
  ```
* start masakari monitors in Compute1 and Compute2 (execute respectively)

  In Ubuntu,

  ```sh
  stack@compute1:~/devstack$ sudo service masakari-hostmonitor start
  stack@compute1:~/devstack$ sudo service masakari-instancemonitor start
  stack@compute1:~/devstack$ sudo service masakari-processmonitor start
  ```
  In CentOS,
  ```sh
  stack@compute1:~/devstack$ sudo systemctl enable masakari-hostmonitor.service
  stack@compute1:~/devstack$ sudo systemctl enable masakari-instancemonitor.service
  stack@compute1:~/devstack$ sudo systemctl enable masakari-processmonitor.service
  ```
### Demonstration of Failover
* set Compute2 as a reserved host of masakari, in Controller

  ```sh
  stack@controller:~/devstack$ cd ~/masakari
  stack@controller:~/masakari$ ./reserved_host_add.sh compute2
  ```
* disable Compute2 from nova scheduler

  ```sh
  stack@controller:~/masakari$ cd ~/devstack/
  stack@controller:~/devstack$ . openrc admin admin
  stack@controller:~/devstack$ nova service-disable compute2 nova-compute
  ```
* create a server instance

  ```sh
  stack@controller:~/devstack$ . openrc admin admin
  stack@controller:~/devstack$ nova flavor-create m1.nano auto 64 1 1
  stack@controller:~/devstack$ . openrc demo demo
  stack@controller:~/devstack$ nova boot --image cirros-0.3.4-x86_64-uec --flavor m1.nano vm1
  ```
* check if the instance is running on Compute1

  ```sh
  stack@controller:~/devstack$ . openrc admin admin
  stack@controller:~/devstack$ nova hypervisor-servers compute1
  stack@controller:~/devstack$ nova hypervisor-servers compute2
  ```
* stop Compute1 suddenly, emulating Compute1 failure

  ```sh
  $ vagrant halt compute1 --force
  or
  $ vagrant destroy compute1 --force
  ```
* check if the instance is evacuated to Compute2 and running (Masakari automatically move the instance. It takes about 5 minutes until it moves.)

  ```sh
  stack@controller:~/devstack$ nova hypervisor-servers compute1
  stack@controller:~/devstack$ nova hypervisor-servers compute2
  $ nova --os-tenant-name demo instance-action-list vm1
  ```

### Recovery of Failed Host

* restart(recreate) a failed host with provisioner, Compute1

  ```sh
  $ vagrant up compute1 --provision
  ```
* deploy OpenStack in Compute1 (see above)
* start masakari monitors in Compute1 (see above)
* set Compute1 as a reserved host of masakari, in Controller

  ```sh
  stack@controller:~/devstack$ cd ~/masakari
  stack@controller:~/masakari$ ./reserved_host_add.sh compute1
  ```
* Compute1 was already disabled from nova scheduler by masakari at the time of a host failure
* enable Compute2 from nova scheduler

  ```sh
  stack@controller:~/masakari$ cd ~/devstack/
  stack@controller:~/devstack$ . openrc admin admin
  stack@controller:~/devstack$ nova service-enable compute2 nova-compute
  ```
* Compute2 was already excluded from reserved hosts of masakari at the time of a instance evacuation
* Now, the instance is ready for another host failure of Compute2

### Tips to hold this environment

* store the whole VMs state to resume your work instantly in future

  ```sh
  $ vagrant suspend
  ```
  * resume the stored state

  ```sh
  $ vagrant up
  ````

## Copyright
Copyright (C) 2015 [Nippon Telegraph and Telephone Corporation](http://www.ntt.co.jp/index_e.html).
Released under [Apache License 2.0](LICENSE).
