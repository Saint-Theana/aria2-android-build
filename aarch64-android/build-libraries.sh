#!/bin/bash

EXPAT=http://starry-sky.me/expat-2.2.0.tar.bz2
ZLIB=http://starry-sky.me/zlib-1.2.11.tar.gz
OPENSSL=http://starry-sky.me/openssl-1.0.2m.tar.gz
C_ARES=http://starry-sky.me/c-ares-1.13.0.tar.gz
SSH2=http://starry-sky.me/libssh2-1.7.0.tar.gz


DOWNLOADER="wget -c"
TOOLCHAIN=$ANDROID_HOME/toolchain
PATH=$TOOLCHAIN/bin:$PATH
HOST=aarch64-linux-android
PREFIX=$ANDROID_HOME/usr/local
LOCAL_DIR=$ANDROID_HOME/usr/local
TOOL_BIN_DIR=$ANDROID_HOME/toolchain/bin
PATH=${TOOL_BIN_DIR}:$PATH
CFLAGS="-march=armv8-a -mtune=cortex-a53"
DEST=$ANDROID_HOME/usr/local
CC=$HOST-gcc
CXX=$HOST-g++
LDFLAGS="-L$DEST/lib"
CPPFLAGS="-I$DEST/include"
CXXFLAGS=$CFLAGS

cd /tmp
#
 # zlib library build
  $DOWNLOADER $ZLIB
  tar zxvf zlib-1.2.11.tar.gz
  cd zlib-1.2.11/
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc STRIP=$HOST-strip RANLIB=$HOST-ranlib CXX=$HOST-g++ AR=$HOST-ar LD=$HOST-ld ./configure --prefix=$PREFIX --static
  make
  make install
#
#
 # expat library build
  cd ..
  $DOWNLOADER $EXPAT
  tar jxvf expat-2.2.0.tar.bz2
  cd expat-2.2.0/
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc CXX=$HOST-g++ ./configure --host=$HOST --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` --prefix=$PREFIX --enable-static=yes --enable-shared=no
  make
  make install
#
#
 # c-ares library build
  cd tmp
  $DOWNLOADER $C_ARES
  tar zxvf c-ares-1.13.0.tar.gz
  cd c-ares-1.13.0/
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc CXX=$HOST-g++ ./configure --host=$HOST --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` --prefix=$PREFIX --enable-static --disable-shared
  make
  make install
#
 # openssl library build
  cd /tmp
  $DOWNLOADER $OPENSSL
  tar zxvf openssl-1.0.2m.tar.gz
  cd openssl-1.0.2m/
  PKG_CONFIG_PATH=$ANDROID_HOME/usr/local/lib/pkgconfig/ LD_LIBRARY_PATH=$ANDROID_HOME/usr/local/lib/ CC=$HOST-gcc CXX=$HOST-g++ ./Configure linux-aarch64 $CFLAGS --prefix=$PREFIX shared zlib zlib-dynamic -D_GNU_SOURCE -D_BSD_SOURCE --with-zlib-lib=$LOCAL_DIR/lib --with-zlib-include=$LOCAL_DIR/include
  make CC=$CC
  make install_sw
#
#
 # libssh2 library build
  cd /tmp
  $DOWNLOADER $SSH2
  tar zxvf libssh2-1.7.0.tar.gz
  cd libssh2-1.7.0/
  rm -rf $PREFIX/lib/pkgconfig/libssh2.pc
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc CXX=$HOST-g++ AR=$HOST-ar RANLIB=$HOST-ranlib CPPFLAGS="-I$ANDROID_HOME/usr/local/include" LDFLAGS="-L$ANDROID_HOME/usr/local/lib" ./configure --prefix="$ANDROID_HOME/usr/local/" --with-openssl --with-libssl-prefix=$ANDROID_HOME/usr/local/ --host=$HOST
  make
  make install
  cd /tmp
  rm -rf c-ares*
  rm -rf sqlite-autoconf*
  rm -rf zlib-*
  rm -rf expat-*
  rm -rf openssl-*
  rm -rf libssh2-*
#
 echo "all complete!"
