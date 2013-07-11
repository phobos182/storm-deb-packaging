#!/bin/bash
set -x
name=libzmq1
version=2.1.7
description='The 0MQ lightweight messaging kernel is a library which extends the
    standard socket interfaces with features traditionally provided by
    specialised messaging middleware products. 0MQ sockets provide an
    abstraction of asynchronous message queues, multiple messaging
    patterns, message filtering (subscriptions), seamless access to
    multiple transport protocols and more.
    .
    This package contains the ZeroMQ shared library.'
url='http://www.zeromq.org/'
arch="$(dpkg --print-architecture)"
section="misc"
package_version=""
src_package="zeromq-${version}.tar.gz"
download_url="http://download.zeromq.org/${src_package}"
origdir="$(pwd)"

#_ MAIN _#
# Cleanup old debian files
rm -rf ${name}*.deb
# If temp directory exists, remove if
if [ -d tmp ]; then
  rm -rf tmp
fi
# Make build directory, save location
mkdir -p tmp && pushd tmp
#_ DOWNLOAD & COMPILE _#
curl -s -o ${src_package} ${download_url}
tar -zxf ${src_package}
cd zeromq-${version}/
mkdir -p build
./configure
make
if [ $? != 0 ]; then
  echo "Failed to build ${name}. Please ensure all dependencies are installed."
  exit $?
fi
make install DESTDIR=`pwd`/build

#_ MAKE DEBIAN _#
cd build
fpm -t deb \
    -n ${name} \
    -v ${version}${package_version} \
    --description "${description}" \
    --url="${url}" \
    -a ${arch} \
    --category ${section} \
    --prefix=/ \
    -d 'libc6 >= 2.7'  -d 'libgcc1 >= 1:4.1.1'  -d 'libstdc++6 >= 4.1.1'  -d 'libuuid1 >= 2.16' \
    --after-install ${origdir}/shlib.postinst \
    --after-remove ${origdir}/shlib.postuninst \
    -s dir \
     -- .
mv ${name}*.deb ${origdir}
popd
