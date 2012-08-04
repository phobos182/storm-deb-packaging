Storm Debian Packaging
==============================================================

Build scripts / sample configuration for building a Storm .deb with FPM

Requirements
------------
To make it as pain free as possible, I have used FPM to build the debian packaging. You can install it by via rubygems (gem install -r fpm). The build_storm.sh script will setup a target directory with the format required for FPM to turn a directory into a .deb package. As a bonus, if you want to change the structure of the package, just change the script to modify the target directory. Then issue the FPM build command, and you are good to go.

* FPM (<https://github.com/jordansissel/fpm/>)
* WGet

I have supplied some default Upstart scripts for use with the packaging. They assume your primary interface is ETH0, so you may want to change that if it's not the case. Since there is no way to update-rc.d an upstart script, there is an option for 'ENABLE=yes' in /etc/default/storm-process. So using your favorite configuration management engine, you can change this to 'yes' to start the daemon on reboot.

Usage
-----
Just run the build_storm.sh script. Package will be in the build directory.

ToDo
-----
* Going to upload the build scripts for libjzmq & libzmq0 as I have listed them as requirements for this script
