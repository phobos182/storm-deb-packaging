#!/bin/bash
set -x
name=storm
version=0.8.1
description="Storm is a distributed realtime computation system. Similar to how Hadoop provides a set of general primitives for doing batch processing, Storm provides a set of general primitives for doing realtime computation. Storm is simple, can be used with any programming language, is used by many companies, and is a lot of fun to use!"
url="http://storm-project.net"
arch="all"
section="misc"
package_version=""
src_package="storm-${version}.zip"
download_url="https://github.com/downloads/nathanmarz/storm/${src_package}"
origdir="$(pwd)"
storm_root_dir=/usr/lib/storm

#_ MAIN _#
# Cleanup old debian files
rm -rf ${name}*.deb
# If temp directory exists, remove if
if [ -d tmp ]; then
  rm -rf tmp
fi
# Download code if not exists
if [[ ! -f "${src_package}" ]]; then
  curl -L -s -o ${src_package} ${download_url}
fi
# Make build directory, save location
mkdir -p tmp && pushd tmp
# Create build structure for package
mkdir -p storm
cd storm
mkdir -p build${storm_root_dir}
mkdir -p build/etc/default
mkdir -p build/etc/storm
mkdir -p build/etc/init
mkdir -p build/etc/init.d
mkdir -p build/var/log/storm

# Explode downloaded archive & cleanup files
unzip ${origdir}/storm-${version}.zip
rm -rf storm-${version}/logs
rm -rf storm-${version}/log4j
rm -rf storm-${version}/conf
cp -R storm-${version}/* build${storm_root_dir}

# Copy default files into build structure
cd build
cp ${origdir}/storm ${origdir}/storm-nimbus ${origdir}/storm-supervisor ${origdir}/storm-ui ${origdir}/storm-drpc etc/default
cp ${origdir}/storm.yaml etc/storm
cp ${origdir}/storm.log.properties etc/storm
cp ${origdir}/storm-nimbus.conf ${origdir}/storm-supervisor.conf ${origdir}/storm-ui.conf ${origdir}/storm-drpc.conf etc/init
#_ Symlinks for upstart init scripts
for f in etc/init/*; do f=$(basename $f); f=${f%.conf}; ln -s /lib/init/upstart-job etc/init.d/$f; done

#_ MAKE DEBIAN _#
cd build
fpm -t deb \
    -n $name \
    -v ${version}${package_version} \
    --description "$description" \
    --before-install ${origdir}/storm.preinst \
    --after-install ${origdir}/storm.postinst \
    --after-remove ${origdir}/storm.postrm \
    --url="${url}" \
    -a ${arch} \
    --prefix=/ \
    -d "libzmq1 >= 2.1.7" -d "libjzmq >= 2.1.7" \
    -s dir \
    -- .
mv ${name}*.deb ${origdir}
popd
