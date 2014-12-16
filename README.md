# Mercury Vagrant (HGV) #

This project is meant to allow people in the WordPress community run a single Vagrant for developing, debugging, and deploying HHVM based code. We have also added standard PHP to test against so that this project is useful for more standard development as well.

The project is also intended as a tool for allowing WP Engine users to test their code prior to actual deployment on WP Engine "Mercury" infrastructure. This is not intended as an exact replica of WP Engine's infrastructure, but is instead a "simulator" of the conditions and software stack on WPE's Mercury platform, allowing you to develop and test your code with an end goal of stability and compatibility with Mercury.

Mercury differs from standard WordPress hosting in several ways, chief among which is the use of HHVM to serve all PHP code. To quote [HHVM's Website](http://hhvm.com):

> HHVM is an open-source virtual machine designed for executing programs written in Hack and PHP. HHVM uses a just-in-time (JIT) compilation approach to achieve superior performance while maintaining the development flexibility that PHP provides.

We have some great [getting started videos and guides here](http://wpengine.com/mercury/how-to-start/) if you want a more guided experience.

## About ##

Mercury Vagrant is a WP Engine creation in partnership with community members.

**Version:** 0.1

**Latest Stable:** 0.1

**Web:** [http://wpengine.com/mercury](http://wpengine.com/mercury)

**Project Lead:** Tomás Puig

**Contributors:** Mark Kelnar, Doug Stewart, Zach Brown, RC Johnson, Jason Cohen, Kailey Lampert, Cameron Benedict, and Grant Landram

**Thanks:** To the [VVV](http://varyingvagrantvagrants.org/) team and others who have worked on the open source we've included.

## Prerequisites ##
In order to use HGV effectively, you'll need to have a few tools installed on your computer. You should:

1. Install [Git](http://git-scm.org).
 * Windows users: Be sure to add the Git executables to your path (See, e.g. [this guide](https://eamann.com/tech/vagrant-windows/), under "Prerequisites")
2. Install virtual machine software ([VMware](http://vmware.com) or [VirtualBox](http://virtualbox.org) are recommended).
3. Install [Vagrant](http://vagrantup.com)
4. **Optional, but highly recommended:** Install the [Vagrant Hostsupdater plugin](https://github.com/cogitatio/vagrant-hostsupdater)
 * Short version: `vagrant plugin install vagrant-hostsupdater`
5. **Suggestion:** Development workstation/laptop should have at least 8GB of RAM. hgv needs to allocate 1GB of RAM in order to run. (Users with <=4GB of RAM [e.g. base-model MacBook Airs] have seen overall system slowness while running this Vagrant box and much of anything else.)
6. Windows users should be certain that their BIOS' virtualization settings are enabled. (Intel owners should enable VT-x while AMD owners should enable AMD-v. See [here](http://www.sysprobs.com/disable-enable-virtualization-technology-bios) for a better explanation.)
7. **Recommendation:** This Vagrant box uses a 64 bit operating system (because HHVM requires a 64 bit OS), so we highly recommend that it only be run on 64 bit machines running 64 bit operating systems. (Most, if not all desktops and laptops sold in the last few years are running on 64 bit processors. Some may not be running 64 bit operating systems, however. Please check your system's documentation.)

## Installation ##
1. `git clone --recursive https://github.com/wpengine/hgv.git` to clone the latest version of the tool.
2. Change into the directory `hgv`.
3. Run `vagrant up`.

## What you get ##
### Software stack ###
HGV uses a mixture of Vagrant's [shell provisioner](https://docs.vagrantup.com/v2/provisioning/shell.html) to kick things off and then uses a tool called [Ansible](http://docs.ansible.com) to complete the configuration of the system.

Once Vagrant is done provisioning the VM, you will have a box running Ubuntu 14.04 (aka Trusty Tahr) containing:

* [Percona DB](http://percona.com)
* [PHP-FPM](http://php-fpm.org)
* [HHVM](http://hhvm.com)
* [Nginx](http://nginx.com)
* [Varnish](http://varnish-cache.org)
* [Memcached](http://memcached.org)

## Next Steps ##
Once the VM is done provisioning, direct your browser to [http://hgv.dev](http://hgv.dev) You will receive fuller instructions on the use of this Vagrant environment there.

### Once Installed These Local URLs / SITES Contain Great Documentation ###
No really, make sure you go to these to check them out as you work with HGV. HGV automatically creates four sites and adds host file entries for them (if you installed the `vagrant-hostsupdater` plugin, that is):

* [hgv.dev](http://hgv.dev) -- General documentation and links for all of the tools
* [hhvm.hgv.dev](http://hhvm.hgv.dev) -- A new WordPress installation running on HHVM
* [php.hgv.dev](http://php.hgv.dev) -- A new WordPress installation running on PHP-FPM (PHP 5.5)
* [admin.hgv.dev](http://admin.hgv.dev) -- Useful administrative tools (phpMyAdmin, etc.)

If you did not install the `vagrant-hostsupdater` plugin, you will need to manually [add](http://www.howtogeek.com/howto/27350/beginner-geek-how-to-edit-your-hosts-file/) the following host entries to your host operating system's host files:

```conf
192.168.150.20 hgv.dev
192.168.150.20 admin.hgv.dev
192.168.150.20 hhvm.hgv.dev
192.168.150.20 php.hgv.dev
192.168.150.20 cache.hhvm.hgv.dev
192.168.150.20 cache.php.hgv.dev
192.168.150.20 xhprof.hgv.dev
```

## Using URLs to View Different Stacks Running Your Code ##

There are two default WordPress installations provided. Both have an admin user *wordpress* with a password *wordpress* (so secure!) already created.

### php.hgv.dev ###

[php.hgv.dev](http://php.hgv.dev) is a basic WordPress install running the latest stable version of WordPress on a fairly standard [LEMP](https://lemp.io/) stack consisting of Nginx, PHP-FPM, and Percona DB.

### hhvm.hgv.dev ###

[hhvm.hgv.dev](hhvm.hgv.dev) is a basic WordPress install running the latest stable version of WordPress on top of an Nginx + HHVM + Percona DB stack.

### Varnish Testing ###

The following URLs will let you view a specific page with caching turned on to test for dynamic content performance.

* [cache.php.hgv.dev](http://cache.php.hgv.dev)
* [cache.hhvm.hgv.dev](http://cache.hhvm.hgv.dev)

## Development and debugging ##
### WordPress developer tools ###

The following WordPress tools and plugins are installed on each WP site (but are not enabled) by default. We highly recommend you try them out if you have not before:

* [query-monitor](https://wordpress.org/plugins/query-monitor/)
* [debug-objects](https://wordpress.org/plugins/debug-objects/)
* [debug-bar](https://wordpress.org/plugins/debug-bar/)
* [p3-profiler](https://wordpress.org/plugins/p3-profiler/)

### Accessing the sites on-disk ###
HGV utilizes VirtualBox's [shared folders](https://www.virtualbox.org/manual/ch04.html#sharedfolders) to create a folder that is accessible from both the HGV virtual machine and your operating system. You can access the WP installations directly by going to `[HGV directory]/wpengine_data/sites/php` and `[HGV directory]/wpengine_data/sites/php` in the Finder (Mac)/Explorer (Windows)/filesystem navigator of choice (Linux, Free/Open/NetBSD, etc.)

### Installing plugins and themes ###

Installing new plugins and themes is as simple as putting themes in `[HGV directory]/wpengine_data/sites/[hhvm|php]/wp-content/[plugins|themes]`

### Command line (CLI) access ###

To connect to the Vagrant instance, type `vagrant ssh` from inside of the HGV directory. This will place you in the CLI on the VM.

### Viewing log files ###

Once you are connected to the HGV virtual machine, system and web server logs can be viewed in
`/var/log` . You may view the contents of the system log by typing `sudo less /var/log/syslog`.

Web server logs are stored in `/var/log/nginx`, with separate log files for every site. Each site has several log files associated with it:

* `[site].hgv.dev.access.log`
* `[site].hgv.dev.apachestyle.access.log`
* `[site].hgv.dev.error.log`

The first two logs track web requests to the sites, while the third log tracks errors reported, both by Nginx and by "upstream" PHP and HHVM processes.

HHVM logs are in `/var/log/hhvm` . PHP-FPM writes all of its logging information into
`/var/log/php5-fpm.log` .

Sometimes, keeping tabs on a log file while hitting a site to view log messages in real-time can be helpful. To do so, run `sudo tail -f [log file]` from your SSH session. For example, `sudo tail -f /var/log/nginx/php.hgv.dev.error.log` would give you an alwaysupdating view of the error log file for the PHP-FPM-based site.

### Database access ###

You may easily use the phpMyAdmin installation at [admin.hgv.dev/phpmyadmin/](admin.hgv.dev/phpmyadmin/) (as listed above) in order to view and interact with the underlying database. However, if you are used to using a third-party GUI, such as [Sequel Pro](http://www.sequelpro.com/) or [MySQL Workbench](http://www.mysql.com/products/workbench/), TCP port 3306 (the MySQL/Percona port) is forwarded from the Vagrant VM to TCP port 23306 on your actual machine. You would then configure MySQL WB or Sequel Pro to connect to `localhost:23306` .

### Developer tools ###

The following useful developer tools are installed by default:

* [Git](http://git-scm.com)
* [Subversion](https://subversion.apache.org/)
* [cURL](http://curl.haxx.se)
* [Ack](http://beyondgrep.com)
* [Autojump](https://github.com/joelthelion/autojump)
* [Siege](http://www.joedog.org/siege-home/)
* [Composer](https://getcomposer.org)
* [PsySH](http://psysh.org)
* [Boris](https://github.com/d11wtq/boris)
* [Xdebug](http://xdebug.org)
* [XHProf](http://php.net/xhprof)
* [PHPUnit](https://phpunit.de)

### Xdebug ###

PHP's [Xdebug extension](http://xdebug.org) is enabled by default for the site based on PHP-FPM. Additionally, the WordPress installs have the following constants defined:

```php
define('WP_DEBUG', true);
define('WP_DEBUG_DISPLAY', false);
define('SCRIPT_DEBUG', true);
define('SAVEQUERIES', true);
```

Enabling the Query Monitor WordPress plugin will allow logged-in users to view the useful debug information output by Xdebug, such as number of queries, number of objects, page render time, etc.

### XHProf ###
HGV includes an advanced PHP/HHVM profiling tool, [http://php.net/xhprof](http://php.net/xhprof) and a GUI for viewing results. You can view results for your HGV instance at [xhprof.hgv.dev](http://xhprof.hgv.dev).

Initially, there will be no profiling data -- you'll need to enable profiling for the various HGV sites. You can enable profiling by passing `_profile=1` to any PHP request on the host. To get started, visit:

* [http://php.hgv.dev/?_profile=1](http://php.hgv.dev/?_profile=1)
* [http://hhvm.hgv.dev/?_profile=1](http://hhvm.hgv.dev/?_profile=1)

Passing the `_profile=1` argument to the sites causes XHProf to set a cookie. While this cookie is active, XHProf will attempt to profile all of your page views. Visit a few URLs on your PHP and HHVM sites, then visit [xhprof.hgv.dev](http://xhprof.hgv.dev) again. You should see profiling results displayed for your interactions with the sites.

When you want to disable profiling, simply append `_profile=0` to any request, or visit these links:

* [http://php.hgv.dev/?_profile=0](http://php.hgv.dev/?_profile=0)
* [http://hhvm.hgv.dev/?_profile=0](http://hhvm.hgv.dev/?_profile=0)

Visiting those links should delete the cookie and disable XHProf.

## Admin Tools ##

HGV contains several useful tools for gathering system state and for administering individual aspects of the system.

### Database ###
phpMyAdmin is available at [admin.hgv.dev/phpmyadmin/](admin.hgv.dev/phpmyadmin/). The username is `root` and the password is blank.

### Object Cache/Memcached ###

phpMemcachedAdmin is available at [admin.hgv.dev/phpmemcachedadmin/](admin.hgv.dev/phpmemcachedadmin/). You may use this tool to check on the status of the WordPress object [cache](http://codex.wordpress.org/Class_Reference/WP_Object_Cache).

## More Documentation/Information ##

For detailed how to install guides per OS and other debugging information please see the [wiki here on github](https://github.com/wpengine/hgv/wiki).

## HGV FAQ ##

### I already use VVV, why do I need HGV? ###

One of the great features of Vagrant is it allows developers to work locally on an environment that is as close as possible to their production environment.  While [VVV](https://github.com/varying-vagrant-vagrants/vvv) is an excellent WordPress development environment, it does not match any one hosting provider’s stack, it simply offers a common configuration.  HGV allows you to code locally on an environment that simulates the WPEngine Mercury platform, a highly tuned WordPress stack with forward looking technology not widely offered in the hosting ecosystem.  WPEngine has worked closely with Facebook to tune HHVM for the needs of WordPress, so you won’t get these constantly updating and improving configurations anywhere else.  

### What is the license for HGV? ###

HGV is Open Source and [GPLv2](http://www.gnu.org/licenses/gpl-2.0.html).

### How do I use my own domain? ###

You can set that up manually, but currently there’s no automatic way to provision this and it is not supported in our documentation at this time.

### How do I remove HGV from my system? ###

From within the same directory you did “vagrant up” originally, type “vagrant destroy”.  The virtual machine will be destroyed (along with anything in it, so be sure to backup your databases!) and you can safely delete the directory if you don’t need to save any files within it.  HGV is continually improving, so feel free to reinstall and “destroy” as many times as you’d like!

### Can I contribute back to HGV? ###

Yes! HGV is open-sourced and hosted on GitHub. We encourage all users to submit bug reports and pull requests with features they would like to see. See the contributing file for how to start and rules.

### What does “stdin: is not a tty” mean? ###

Due to the way that Ubuntu configures its users, you may encounter this error the first time you run vagrant up or vagrant provision. It can safely be ignored and the provisioning process itself should remove the error on subsequent runs.
