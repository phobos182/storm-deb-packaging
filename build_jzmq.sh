#!/bin/bash
set -x
name=libjzmq
version=2.1.7
description="JZMQ is the Java bindings for ZeroMQ"
url='https://github.com/nathanmarz/jzmq.git'
arch="$(dpkg --print-architecture)"
section="misc"
package_version=""
origdir="$(pwd)"
prefix="/usr"

# Make sure JAVA_HOME is set. Uncomment if necessary
if [ "${JAVA_HOME}x" == "x" ]; then
  echo Please set JAVA_HOME before running.
  exit -1
fi

#_ MAIN _#
# Cleanup old debian files
rm -rf ${name}*.deb
# If temp directory exists, remove if
if [ -d tmp ]; then
  rm -rf tmp
fi
# Make build directory, save location
mkdir -p tmp && pushd tmp
# Clone Git repository & make build directory
git clone ${url}
cd jzmq
mkdir -p build
# Patch for 12.x releases
if [ $(cat /etc/lsb-release|grep -i release|grep 12\.) ]; then
  curl -vs https://github.com/nathanmarz/jzmq/pull/2.patch 2>/dev/null | patch -p
fi
# Build package
./autogen.sh
./configure --prefix=${prefix}
#cd src/
#CLASSPATH=.:./.:$CLASSPATH
#javac -d . org/zeromq/ZMQ.java org/zeromq/App.java org/zeromq/ZMQForwarder.java org/zeromq/EmbeddedLibraryTools.java org/zeromq/ZMQQueue.java org/zeromq/ZMQStreamer.java org/zeromq/ZMQException.java
#cd ..
make
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
    -m "${USER}@localhost" \
    --prefix=/ \
    -d "libzmq0 >= 2.1.7" \
    -s dir \
    --after-install ${origdir}/shlib.postinst \
    --after-remove ${origdir}/shlib.postuninst \
    -- .
mv ${name}*.deb ${origdir}
popd
