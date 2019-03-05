### Provisioning and initial setup

Although it's not required, it's highly recommended to use the project in a
virtual machine. The project provides `Vagrantfile` to automatically deploy and
provision virtual machine with use of [VirtualBox](https://www.virtualbox.org/)
and [vagrant](https://www.vagrantup.com/) tool. One can use `vagrant up` in the
root directory of the cloned project to launch virtual machine and `vagrant
ssh` to enter it after boot. The following commands should be of use in the
terminal of virtual machine:

*   `bundle install` — install required libraries used by the project;
*   `bundle exec rake db:migrate` — migrate primary database;
*   `bundle exec rake db:seed` — seed primary database with command records,
    player records, games records and performance records;
*   `make console` — launch debug console application;


### Application usage

*   bundle exec bin/player_statistics `action` `*params`

### Description of actions and parameters

*   `add_performance`: `player_id` `performance` (`run` or 'transfer')
*   `check_performance`: `player_id` `performance` (`run` or 'transfer')
*   `top_five`: `performance` (`run` or 'transfer') `command_id` (optional)
