Storm Debian Packaging
==============================================================

Build scripts / sample configuration for building a Storm .deb with FPM

Requirements
------------
To make it as pain free as possible, I have used FPM to build the debian packaging. You can install it by via rubygems (gem install -r fpm). The build_storm.sh script will setup a target directory with the format required for FPM to turn a directory into a .deb package. As a bonus, if you want to change the structure of the package, just change the script to modify the target directory. Then issue the FPM build command, and you are good to go.

* FPM (<https://github.com/jordansissel/fpm/>)
* WGet
* build-essentials + any dependencies for ZeroMQ + JZMQ bindings

I have supplied some default Upstart scripts for use with the packaging. They assume your primary interface is ETH0, so you may want to change that if it's not the case. Since there is no way to update-rc.d an upstart script, there is an option for 'ENABLE=yes' in /etc/default/storm-process. I am currently using Monit, so chose not to have Upstart 'respawn' on process failure. If you would like Upstart to provide this feature, you can add 'respawn' to the scripts and upstart should take care of this for you. So using your favorite configuration management engine, you can change this to 'yes' to start the daemon on reboot. The build scripts provided compile the dependencies listed in <https://github.com/nathanmarz/storm/wiki/Installing-native-dependencies>.

Usage
-----
Included are three scripts to build the debian packages for a storm installation.

* build_storm.sh - Storm
* build_libzmq0.sh - ZeroMQ libraries
* build_jzmq0.sh - Java bindings for ZeroMQ

Just run the build scripts, and debian artifacts will be created.

Here is a sample of the layout of the package structures.

Updates
------
7/11/2013 - Updated Packaging paths / guidelines based on forks. Tested on 0.8.1 on 11.04 + 12.04

Storm Package
------
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./etc/
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./etc/storm/
    -rw-r--r-- root/root       364 2013-07-12 01:18 ./etc/storm/storm.log.properties
    -rw-r--r-- root/root       445 2013-07-12 01:18 ./etc/storm/storm.yaml
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./etc/init/
    -rw-r--r-- root/root       742 2013-07-12 01:18 ./etc/init/storm-nimbus.conf
    -rw-r--r-- root/root       726 2013-07-12 01:18 ./etc/init/storm-drpc.conf
    -rw-r--r-- root/root       709 2013-07-12 01:18 ./etc/init/storm-ui.conf
    -rw-r--r-- root/root       768 2013-07-12 01:18 ./etc/init/storm-supervisor.conf
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./etc/init.d/
    lrwxrwxrwx root/root         0 2013-07-12 01:18 ./etc/init.d/storm-supervisor -> /lib/init/upstart-job
    lrwxrwxrwx root/root         0 2013-07-12 01:18 ./etc/init.d/storm-nimbus -> /lib/init/upstart-job
    lrwxrwxrwx root/root         0 2013-07-12 01:18 ./etc/init.d/storm-ui -> /lib/init/upstart-job
    lrwxrwxrwx root/root         0 2013-07-12 01:18 ./etc/init.d/storm-drpc -> /lib/init/upstart-job
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./etc/default/
    -rw-r--r-- root/root       283 2013-07-12 01:18 ./etc/default/storm-supervisor
    -rw-r--r-- root/root       253 2013-07-12 01:18 ./etc/default/storm-nimbus
    -rw-r--r-- root/root       225 2013-07-12 01:18 ./etc/default/storm-ui
    -rw-r--r-- root/root       353 2013-07-12 01:18 ./etc/default/storm
    -rw-r--r-- root/root       239 2013-07-12 01:18 ./etc/default/storm-drpc
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./usr/
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./usr/lib/
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./usr/lib/storm/
    -rw-r--r-- root/root      3730 2013-07-12 01:18 ./usr/lib/storm/README.markdown
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./usr/lib/storm/public/
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./usr/lib/storm/public/js/
    -rw-r--r-- root/root      5496 2013-07-12 01:18 ./usr/lib/storm/public/js/jquery.cookies.2.2.0.min.js
    -rw-r--r-- root/root     16532 2013-07-12 01:18 ./usr/lib/storm/public/js/jquery.tablesorter.min.js
    -rw-r--r-- root/root     91555 2013-07-12 01:18 ./usr/lib/storm/public/js/jquery-1.6.2.min.js
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./usr/lib/storm/public/css/
    -rw-r--r-- root/root     42139 2013-07-12 01:18 ./usr/lib/storm/public/css/bootstrap-1.1.0.css
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./usr/lib/storm/lib/
    -rw-r--r-- root/root    279193 2013-07-12 01:18 ./usr/lib/storm/lib/commons-lang-2.5.jar
    -rw-r--r-- root/root    601677 2013-07-12 01:18 ./usr/lib/storm/lib/zookeeper-3.3.3.jar
    -rw-r--r-- root/root    181041 2013-07-12 01:18 ./usr/lib/storm/lib/httpcore-4.1.jar
    -rw-r--r-- root/root    351132 2013-07-12 01:18 ./usr/lib/storm/lib/httpclient-4.1.1.jar
    -rw-r--r-- root/root      7898 2013-07-12 01:18 ./usr/lib/storm/lib/hiccup-0.3.6.jar
    -rw-r--r-- root/root     51426 2013-07-12 01:18 ./usr/lib/storm/lib/disruptor-2.10.1.jar
    -rw-r--r-- root/root      2441 2013-07-12 01:18 ./usr/lib/storm/lib/ring-jetty-adapter-0.3.11.jar
    -rw-r--r-- root/root    161272 2013-07-12 01:18 ./usr/lib/storm/lib/kryo-2.17.jar
    -rw-r--r-- root/root    121070 2013-07-12 01:18 ./usr/lib/storm/lib/junit-3.8.1.jar
    -rw-r--r-- root/root     99382 2013-07-12 01:18 ./usr/lib/storm/lib/curator-framework-1.0.1.jar
    -rw-r--r-- root/root     57779 2013-07-12 01:18 ./usr/lib/storm/lib/commons-fileupload-1.2.1.jar
    -rw-r--r-- root/root     60686 2013-07-12 01:18 ./usr/lib/storm/lib/commons-logging-1.1.1.jar
    -rw-r--r-- root/root     87325 2013-07-12 01:18 ./usr/lib/storm/lib/jline-0.9.94.jar
    -rw-r--r-- root/root     36046 2013-07-12 01:18 ./usr/lib/storm/lib/objenesis-1.2.jar
    -rw-r--r-- root/root      4646 2013-07-12 01:18 ./usr/lib/storm/lib/math.numeric-tower-0.0.1.jar
    -rw-r--r-- root/root      3362 2013-07-12 01:18 ./usr/lib/storm/lib/tools.cli-0.2.2.jar
    -rw-r--r-- root/root     65612 2013-07-12 01:18 ./usr/lib/storm/lib/reflectasm-1.07-shaded.jar
    -rw-r--r-- root/root     16835 2013-07-12 01:18 ./usr/lib/storm/lib/ring-core-0.3.10.jar
    -rw-r--r-- root/root     25042 2013-07-12 01:18 ./usr/lib/storm/lib/curator-client-1.0.1.jar
    -rw-r--r-- root/root      7088 2013-07-12 01:18 ./usr/lib/storm/lib/tools.logging-0.2.3.jar
    -rw-r--r-- root/root     23445 2013-07-12 01:18 ./usr/lib/storm/lib/slf4j-api-1.5.8.jar
    -rw-r--r-- root/root     58160 2013-07-12 01:18 ./usr/lib/storm/lib/commons-codec-1.4.jar
    -rw-r--r-- root/root      3129 2013-07-12 01:18 ./usr/lib/storm/lib/core.incubator-0.1.0.jar
    -rw-r--r-- root/root     52543 2013-07-12 01:18 ./usr/lib/storm/lib/commons-exec-1.1.jar
    -rw-r--r-- root/root     58476 2013-07-12 01:18 ./usr/lib/storm/lib/carbonite-1.5.0.jar
    -rw-r--r-- root/root    539912 2013-07-12 01:18 ./usr/lib/storm/lib/jetty-6.1.26.jar
    -rw-r--r-- root/root    569231 2013-07-12 01:18 ./usr/lib/storm/lib/joda-time-2.0.jar
    -rw-r--r-- root/root     46022 2013-07-12 01:18 ./usr/lib/storm/lib/asm-4.0.jar
    -rw-r--r-- root/root    109043 2013-07-12 01:18 ./usr/lib/storm/lib/commons-io-1.4.jar
    -rw-r--r-- root/root    481535 2013-07-12 01:18 ./usr/lib/storm/lib/log4j-1.2.16.jar
    -rw-r--r-- root/root      3210 2013-07-12 01:18 ./usr/lib/storm/lib/ring-servlet-0.3.11.jar
    -rw-r--r-- root/root    177131 2013-07-12 01:18 ./usr/lib/storm/lib/jetty-util-6.1.26.jar
    -rw-r--r-- root/root    265825 2013-07-12 01:18 ./usr/lib/storm/lib/snakeyaml-1.9.jar
    -rw-r--r-- root/root      5170 2013-07-12 01:18 ./usr/lib/storm/lib/tools.macro-0.1.0.jar
    -rw-r--r-- root/root      5529 2013-07-12 01:18 ./usr/lib/storm/lib/compojure-0.6.4.jar
    -rw-r--r-- root/root    245255 2013-07-12 01:18 ./usr/lib/storm/lib/jgrapht-0.8.3.jar
    -rw-r--r-- root/root      9386 2013-07-12 01:18 ./usr/lib/storm/lib/clj-time-0.4.1.jar
    -rw-r--r-- root/root      9679 2013-07-12 01:18 ./usr/lib/storm/lib/slf4j-log4j12-1.5.8.jar
    -rw-r--r-- root/root   3421683 2013-07-12 01:18 ./usr/lib/storm/lib/clojure-1.4.0.jar
    -rw-r--r-- root/root     16046 2013-07-12 01:18 ./usr/lib/storm/lib/json-simple-1.1.jar
    -rw-r--r-- root/root      3067 2013-07-12 01:18 ./usr/lib/storm/lib/clout-0.4.1.jar
    -rw-r--r-- root/root     13631 2013-07-12 01:18 ./usr/lib/storm/lib/jzmq-2.1.0.jar
    -rw-r--r-- root/root    302470 2013-07-12 01:18 ./usr/lib/storm/lib/libthrift7-0.7.0.jar
    -rw-r--r-- root/root      4965 2013-07-12 01:18 ./usr/lib/storm/lib/minlog-1.2.jar
    -rw-r--r-- root/root    105112 2013-07-12 01:18 ./usr/lib/storm/lib/servlet-api-2.5.jar
    -rw-r--r-- root/root   1891102 2013-07-12 01:18 ./usr/lib/storm/lib/guava-13.0.jar
    -rw-r--r-- root/root    134133 2013-07-12 01:18 ./usr/lib/storm/lib/servlet-api-2.5-20081211.jar
    -rw-r--r-- root/root     12710 2013-07-12 01:18 ./usr/lib/storm/LICENSE.html
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./usr/lib/storm/bin/
    -rwxr-xr-x root/root       692 2013-07-12 01:18 ./usr/lib/storm/bin/install_zmq.sh
    -rw-r--r-- root/root        78 2013-07-12 01:18 ./usr/lib/storm/bin/javadoc.sh
    -rwxr-xr-x root/root     14209 2013-07-12 01:18 ./usr/lib/storm/bin/storm
    -rw-r--r-- root/root       483 2013-07-12 01:18 ./usr/lib/storm/bin/to_maven.sh
    -rw-r--r-- root/root       659 2013-07-12 01:18 ./usr/lib/storm/bin/build_release.sh
    -rw-r--r-- root/root   4789764 2013-07-12 01:18 ./usr/lib/storm/storm-0.8.1.jar
    -rw-r--r-- root/root     19981 2013-07-12 01:18 ./usr/lib/storm/CHANGELOG.md
    -rw-r--r-- root/root         6 2013-07-12 01:18 ./usr/lib/storm/RELEASE
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./var/
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./var/log/
    drwxr-xr-x root/root         0 2013-07-12 01:18 ./var/log/storm/
