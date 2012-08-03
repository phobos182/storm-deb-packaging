#!/bin/bash
name=storm
version=0.7.4
url=http://storm-project.net
buildroot=build
fakeroot=storm-${version}
origdir=$(pwd)
description="Storm is a distributed realtime computation system. Similar to how Hadoop provides a set of general primitives for doing batch processing, Storm provides a set of general primitives for doing realtime computation. Storm is simple, can be used with any programming language, is used by many companies, and is a lot of fun to use!"

#_ MAIN _#
rm -rf *.deb
rm -rf ${fakeroot}
mkdir -p ${fakeroot}
wget https://github.com/downloads/nathanmarz/storm/storm-${version}.zip
mv storm-${version}.zip ${fakeroot}
unzip ${fakeroot}/storm-${version}.zip
mv ${fakeroot}/storm-${version}/* ${fakeroot} &>/dev/null
rm -rf ${fakeroot}/storm-${version}.zip
rm -rf ${fakeroot}/logs
rm -rf ${fakeroot}/log4j
rm -rf ${fakeroot}/conf

#_ MAKE DIRECTORIES _#
rm -rf ${buildroot}
mkdir -p ${buildroot}
mkdir -p ${buildroot}/opt/storm
mkdir -p ${buildroot}/etc/default
mkdir -p ${buildroot}/etc/storm/conf.d
mkdir -p ${buildroot}/etc/init
mkdir -p ${buildroot}/var/log/storm
mkdir -p ${buildroot}/var/lib/storm

#_ COPY FILES _#
cp -R ${fakeroot}/* ${buildroot}/opt/storm
cp storm storm-nimbus storm-supervisor storm-ui ${buildroot}/etc/default
cp storm.yaml ${buildroot}/etc/storm
cp storm.log.properties ${buildroot}/etc/storm
cp storm-nimbus.conf storm-supervisor.conf storm-ui.conf ${buildroot}/etc/init

#_ MAKE DEBIAN _#
cd ${buildroot}
fpm -t deb -n $name -v $version --description "$description" --url="$url" -a all --prefix=/ -d "libzmq0 >= 2.1.7" -d "libjzmq >= 2.1.7" -s dir -- .
cd ${origdir}
