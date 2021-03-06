#!/bin/bash
if [ -n "${MAX_PARALLEL}" ]; then
    cpus=${MAX_PARALLEL}
else
    cpus=`ncpus`
fi
echo "Running on ${cpus} cpus"
rm -rf *
(cmake -DCMAKE_BUILD_TYPE=Debug -DWITH_DEBUG=1 -DCMAKE_INSTALL_PREFIX=../percona-server-install-8.0 -DMYSQL_MAINTAINER_MODE=ON -DWITH_EMBEDDED_SERVER=OFF -DWITH_JEMALLOC=system -DWITH_BOOST=../../boost_1_65_0 -DZLIB_INCLUDE_DIR=/usr/include/ $@ ../percona-server && make -j${cpus}) 2>&1 | tee build.log
