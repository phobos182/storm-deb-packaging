#!/bin/bash
name=libzmq0
arch='amd64' # Change to your architecture
version=2.1.7
url='http://www.zeromq.org/'
package="http://download.zeromq.org/zeromq-${version}.tar.gz"
buildroot=build
fakeroot=libzmq0
origdir=$(pwd)
description='The 0MQ lightweight messaging kernel is a library which extends the
    standard socket interfaces with features traditionally provided by
    specialised messaging middleware products. 0MQ sockets provide an
    abstraction of asynchronous message queues, multiple messaging
    patterns, message filtering (subscriptions), seamless access to
    multiple transport protocols and more.
    .
    This package contains the ZeroMQ shared library.'

#_ MAIN _#
#_ MAKE DIRECTORIES _#
rm -rf ${fakeroot}
mkdir -p ${fakeroot}
rm -rf ${buildroot}
mkdir -p ${buildroot}
#_ DOWNLOAD & COMPILE _#
cd ${fakeroot}
wget ${package}
tar -zxvf *.gz
cd zeromq-${version}/
./configure
make
make install DESTDIR=${origdir}/${buildroot}

#_ MAKE DEBIAN _#
cd ${origdir}/${buildroot}
fpm -t deb -n ${name} -v ${version} --description "${description}" --url="${url}" -a ${arch} --prefix=/ -d 'libc6 >= 2.7'  -d 'libgcc1 >= 1:4.1.1'  -d 'libstdc++6 >= 4.1.1'  -d 'libuuid1 >= 2.16' -s dir -- .
cd ${origdir}
