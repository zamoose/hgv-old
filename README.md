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

```192.168.150.20 wpengine.dev```

```192.168.150.20 admin.wpengine.dev```

```192.168.150.20 hhvm.wpengine.dev```

```192.168.150.20 php.wpengine.dev```

```192.168.150.20 cache.hhvm.wpengine.dev```

```192.168.150.20 cache.php.wpengine.dev```

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

To connect to the Vagrant instance, type ```vagrant ssh``` from inside of the HGV directory. This will place you in the CLI on the VM.

## Viewing log files

Once you are connected to the HGV virtual machine, system and web server logs can be viewed in
```/var/log``` . You may view the contents of the system log by typing ```sudo less /var/log/syslog```.

Web server logs are stored in ```/var/log/nginx```, with separate log files for every site. Each site has several log files associated with it:

```[site].wpengine.dev.access.log```

```[site].wpengine.dev.apachestyle.access.log```

```[site].wpengine.dev.error.log```

The first two logs track web requests to the sites, while the third log tracks errors reported, both by Nginx and by "upstream" PHP and HHVM processes.

HHVM logs are in ```/var/log/hhvm```. PHP-FPM writes all of its logging information into
```/var/log/php5-fpm.log```.

Sometimes, keeping tabs on a log file while hitting a site to view log messages in real-time can be helpful. To do so, run ```sudo tail -f [log file]``` from your SSH session. For example, ```sudo tail -f /var/log/nginx/php.wpengine.dev.error.log``` would give you an alwaysupdating view of the error log file for the PHP-FPM-based site.

## Database access

You may easily use the phpMyAdmin installation at [admin.wpengine.dev/phpmyadmin/](admin.wpengine.dev/phpmyadmin/) (as listed above) in order to view and interact with the underlying database. However, if you are used to using a third-party GUI, such as [Sequel Pro](http://www.sequelpro.com/) or [MySQL Workbench](http://www.mysql.com/products/workbench/), TCP port 3306 (the MySQL/Percona port) is forwarded from the Vagrant VM to TCP port 23306 on your actual machine. You would then configure MySQL WB or Sequel Pro to connect to ```localhost:23306```.

## Developer tools

The following developer tools are installed by default:

* Git
* Subversion
* Curl
* Ack
* Autojump
* Siege
* Composer
* PsySH
* Boris
* Xdebug
* XHProf
* PHPUnit

## Xdebug

PHP's Xdebug extension is enabled by default for the site based on PHP-FPM. Additionally, the WordPress installs have the following constants defined:

code()
define('WP_DEBUG', true);
define('WP_DEBUG_DISPLAY', false);
define('SCRIPT_DEBUG', true);
define('SAVEQUERIES', true);

Enabling the Query Monitor WordPress plugin will allow logged-in users to view the useful debug information output by Xdebug, such as number of queries, number of objects, page render time, etc.

# More Documentation Information

For detailed how to install guides per OS and other debugging information please see the [wiki here on github](https://github.com/wpengine/hgv/wiki).

### Contributing

Help us build! We're in beta right now [and seeking help to find bugs](http://wpengine.com/mercury). If you are interested in contributing, jump in! Anyone is welcome to send pull requests. Issue reports are good too, but pull requests are much better. Here's how you do it:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write the code, **and tests to confirm it works**
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

