#!/bin/bash
name=libzmq0
arch='amd64' # Change to your architecture
version=2.1.7
url='https://github.com/nathanmarz/jzmq.git'
buildroot=build
fakeroot=jzmq
origdir=$(pwd)
description='JZMQ is the Java bindings for ZeroMQ'
# Make sure JAVA_HOME is set. Uncomment if necessary
export JAVA_HOME='/usr/lib/jvm/java-6-sun-1.6.0.31'

#_ MAIN _#
rm -rf *.deb
rm -rf jzmq
rm -rf ${buildroot}
mkdir -p ${buildroot}
git clone ${url}
cd jzmq
./autogen.sh
./configure
make
make install DESTDIR=${origdir}/${buildroot}

#_ MAKE DEBIAN _#
cd ${origdir}/${buildroot}
fpm -t deb -n ${name} -v ${version} --description "${description}" --url="${url}" -a ${arch} --prefix=/ -d "libjzmq >= 2.1.7" -s dir -- .
cd ${origdir}
