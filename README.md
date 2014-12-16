## Mercury Vagrant (HGV)

This project is intended as a tool for allowing WP Engine users to test their code prior to actual deployment on WP Engine "Mercury" infrastructure. This is not intended as an exact replica of WP Engine's infrastructure, but is instead a "simulator" of the conditions and software stack on WPE's Mercury platform, allowing you to develop and test your code with an end goal of stability and compatibility with Mercury.

Mercury differs from standard WordPress hosting in several ways, chief among which is the use of HHVM to serve all PHP code. To quote [HHVM's Website](http://hhvm.com):
HHVM is an open-source virtual machine designed for executing programs written in Hack and PHP. HHVM uses a just-in-time (JIT) compilation approach to achieve superior performance while maintaining the development flexibility that PHP provides.

## What you get

## Software stack

Once Vagrant is done provisioning the VM, you will have a box running Ubuntu 14.04 (aka Trusty Tahr) 

###containing:
[Percona DB](http://percona.com)

[PHP-FPM](http://php-fpm.org)

[HHVM](http://hhvm.com)

[Nginx](http://nginx.com)

[Varnish](http://varnish-cache.org)

[Memcached](http://memcached.org)

### Prerequisites

1. Install [Git](http://git-scm.org).
Windows users: Be sure to add the Git executables to your path (See, e.g. this guide, under "Prerequisites")
2. Install virtual machine software ([VMware](http://vmware.com) or [VirtualBox](http://virtualbox.org) are recommended).
3. Install [Vagrant](http://vagrantup.com)
4. Optional, but highly recommended: Install the Vagrant Hostsupdater plugin Short version: vagrant plugin install [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) 
5. Suggestion: Development workstation/laptop should have at least 8GB of RAM. hgv needs to allocate 1GB of RAM in order to run. (Users with <=4GB of RAM [e.g. base-model MacBook Airs] have seen overall system slowness while running this Vagrant box and much of anything else.)
6. Windows users should be certain that their BIOS' virtualization settings are enabled. (Intel owners should enable VT-x while AMD owners should enable AMD-v. See [here](http://www.sysprobs.com/disable-enable-virtualization-technology-bios) for a better explanation.)
7. Recommendation: This Vagrant box uses a 64 bit operating system (because HHVM requires a 64 bit OS), so we highly recommend that it only be run on 64 bit machines running 64 bit operating systems. (Most, if not all desktops and laptops sold in the last few years are running on 64 bit processors. Some may not be running 64 bit operating systems, however. Please check your system's documentation.)

## Installation
1. ```git clone --recursive https://github.com/wpengine/hgv.git``` to clone the latest version
of the tool.
2. Change into the directory ```hgv```.
3. Run ```vagrant up```

## Next Steps
Once the VM is done provisioning, direct your browser to http://wpengine.dev
You will receive fuller instructions on the use of this Vagrant environment there.

## Once Installed These Local URL's / SITES Contain Great Documentation

HGV automatically creates four sites and adds host file entries for them (if you installed the ```vagrant-hostsupdater``` plugin, that is):

No really, make sure you go to these to check them out as you work with HGV.

wpengine.dev -- General documentation and links for all of the tools

hhvm.wpengine.dev -- A new WordPress installation running on HHVM

php.wpengine.dev -- A new WordPress installation running on PHP-FPM (PHP 5.5)

admin.wpengine.dev -- Useful administrative tools (phpMyAdmin, etc.)

If you did not install the ```vagrant-hostsupdater``` plugin, you will need to manually [add](http://www.howtogeek.com/howto/27350/beginner-geek-how-to-edit-your-hosts-file/) the following host entries to your host operating system's host files:

```192.168.150.20 wpengine.dev

192.168.150.20 admin.wpengine.dev

192.168.150.20 hhvm.wpengine.dev

192.168.150.20 php.wpengine.dev

192.168.150.20 cache.hhvm.wpengine.dev

192.168.150.20 cache.php.wpengine.dev```

## WordPress Installations

There are two default ```WordPress``` installations provided. Both have an admin user wordpress with a password ```wordpress``` (so secure!) already created.

# Using URL's to View Different Stacks Running Your Code

## php.wpengine.dev

php.wpengine.dev is a basic WordPress install running the latest stable version of WordPress on a fairly standard [LEMP](https://lemp.io/) stack consisting of Nginx, PHP-FPM, and Percona DB.

## hhvm.wpengine.dev

hhvm.wpengine.dev is a basic WordPress install running the latest stable version of WordPress on top of an Nginx + HHVM + Percona DB stack.

## Varnish Testing

The following URL's will let you view a specific page with caching turned on to test for dynamic content performance.

cache.php.wpengine.dev
cache.hhvm.wpengine.dev

## WordPress developer tools

The following WordPress tools and plugins are installed on each WP site (but are not enabled) by default. We highly recommend you try them out if you have not before:

[query-monitor](https://wordpress.org/plugins/query-monitor/)
[debug-objects](https://wordpress.org/plugins/debug-objects/)
[debug-bar](https://wordpress.org/plugins/debug-bar/)
[p3-profiler](https://wordpress.org/plugins/p3-profiler/)

## Accessing the sites on-disk

When you Users can access the WP installations directly by going to ```[HGV directory]/wpengine_data/sites/php``` and [```HGV directory]/wpengine_data/sites/php``` in the Finder (Mac)/Explorer (Windows)/filesystem navigator of choice (Linux, Free/Open/NetBSD, etc.)

## Installing plugins and themes

Installing new plugins and themes is as simple as putting themes in ```[HGV directory]/wpengine_data/sites/[hhvm|php]/wp-content/[plugins|themes]```

# Admin Tools

HGV contains several useful tools for gathering system state and for administering individual aspects of the system.

## Database
phpMyAdmin is available at [admin.wpengine.dev/phpmyadmin/](admin.wpengine.dev/phpmyadmin/). The username is ```root``` and the password is blank.

## Object Cache/Memcached

phpMemcachedAdmin is available at [admin.wpengine.dev/phpmemcachedadmin/](admin.wpengine.dev/phpmemcachedadmin/). You may use this tool to check on the status of the WordPress object [cache](http://codex.wordpress.org/Class_Reference/WP_Object_Cache).

# Development and debugging

## Command line (CLI) access

To connect to the Vagrant instance, type ```vagrant ssh``` from inside of the HGV directory. This will place you in the CLI on the VM. For example:

```hostname:hgv username$ vagrant ssh
Welcome to Ubuntu 14.04 LTS (GNU/Linux 3.13.0-29-generic x86_64)
* Documentation: https://help.ubuntu.com/
System information as of Mon Dec 15 17:30:03 UTC 2014
System load: 0.01 Processes: 102
Usage of /: 5.0% of 39.34GB Users logged in: 1
Memory usage: 76% IP address for eth0: 10.0.2.15
Swap usage: 0% IP address for eth1: 192.168.150.20
Graph this data and manage this system at:
https://landscape.canonical.com/
Get cloud support with Ubuntu Advantage Cloud Guest:
http://www.ubuntu.com/business/services/cloud
122 packages can be updated.
59 updates are security updates.
Last login: Mon Dec 15 07:05:21 2014 from 10.0.2.2
vagrant@wpengine:~$```

## Viewing log files

## More Documentation Information

For detailed how to install guides per OS and other debugging information please see the [wiki here on github](https://github.com/wpengine/hgv/wiki).

### Contributing

Help us build! We're in beta right now [and seeking help to find bugs](http://wpengine.com/mercury). If you are interested in contributing, jump in! Anyone is welcome to send pull requests. Issue reports are good too, but pull requests are much better. Here's how you do it:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write the code, **and tests to confirm it works**
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

