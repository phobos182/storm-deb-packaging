Storm Debian Packaging
==============================================================

Build scripts / sample configuration for building a Storm .deb with FPM

Requirements
------------
To make it as pain free as possible, I have used FPM to build the debian packaging. You can install it by via rubygems (gem install -r fpm). The build_storm.sh script will setup a target directory with the format required for FPM to turn a directory into a .deb package. As a bonus, if you want to change the structure of the package, just change the script to modify the target directory. Then issue the FPM build command, and you are good to go.

* FPM (<https://github.com/jordansissel/fpm/>)
* WGet
* build-essentials + any dependencies for ZeroMQ + JZMQ bindings

I have supplied some default Upstart scripts for use with the packaging. They assume your primary interface is ETH0, so you may want to change that if it's not the case. Since there is no way to update-rc.d an upstart script, there is an option for 'ENABLE=yes' in /etc/default/storm-process. So using your favorite configuration management engine, you can change this to 'yes' to start the daemon on reboot. The build scripts provided compile the dependencies listed in <https://github.com/nathanmarz/storm/wiki/Installing-native-dependencies>.

Usage
-----
Included are three scripts to build the debian packages for a storm installation.

* build_storm.sh - Storm
* build_libzmq0.sh - ZeroMQ libraries
* build_jzmq0.sh - Java bindings for ZeroMQ

Just run the build scripts, and debian artifacts will be created.

