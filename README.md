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
4. Optional, but highly recommended: Install the Vagrant Hostsupdater plugin Short version: vagrant plugin install vagrant-hostsupdater 
5. Suggestion: Development workstation/laptop should have at least 8GB of RAM. hgv needs to allocate 1GB of RAM in order to run. (Users with <=4GB of RAM [e.g. base-model MacBook Airs] have seen overall system slowness while running this Vagrant box and much of anything else.)
6. Windows users should be certain that their BIOS' virtualization settings are enabled. (Intel owners should enable VT-x while AMD owners should enable AMD-v. See here for a better explanation.)
7. Recommendation: This Vagrant box uses a 64 bit operating system (because HHVM requires a 64 bit OS), so we highly recommend that it only be run on 64 bit machines running 64 bit operating systems. (Most, if not all desktops and laptops sold in the last few years are running on 64 bit processors. Some may not be running 64 bit operating systems, however. Please check your system's documentation.)

## Installation
1. git clone --recursive https://github.com/wpengine/hgv.git to clone the latest version
of the tool.
2. Change into the directory hgv .
3. Run vagrant up

## Next Steps
Once the VM is done provisioning, direct your browser to http://wpengine.dev
You will receive fuller instructions on the use of this Vagrant environment there.

## Sites

### Contributing

Help us build! We're in beta right now [and seeking help to find bugs](http://wpengine.com/mercury). If you are interested in contributing, jump in! Anyone is welcome to send pull requests. Issue reports are good too, but pull requests are much better. Here's how you do it:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write the code, **and tests to confirm it works**
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

