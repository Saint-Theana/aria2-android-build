#!/bin/bash

if [[ $ANDROID_HOME == "" ]];then
echo "ANDROID_HOME not defined"
exit 0
fi


##LIBRARIES_DOWNLOAD_URL##
EXPAT=http://starry-sky.me/expat-2.2.0.tar.bz2
ZLIB=http://starry-sky.me/zlib-1.2.11.tar.gz
OPENSSL=http://starry-sky.me/openssl-1.0.2m.tar.gz
C_ARES=http://starry-sky.me/c-ares-1.13.0.tar.gz
SSH2=http://starry-sky.me/libssh2-1.7.0.tar.gz


DOWNLOADER="wget -c"
TOOLCHAIN=$ANDROID_HOME/toolchain
PATH=$TOOLCHAIN/bin:$PATH
HOST=arm-linux-androideabi
PREFIX=$ANDROID_HOME/usr/local
LOCAL_DIR=$ANDROID_HOME/usr/local
TOOL_BIN_DIR=$ANDROID_HOME/toolchain/bin
PATH=${TOOL_BIN_DIR}:$PATH
CFLAGS="-march=armv7-a -mtune=cortex-a9"
DEST=$ANDROID_HOME/usr/local
CC=$HOST-gcc
CXX=$HOST-g++
LDFLAGS="-L$DEST/lib"
CPPFLAGS="-I$DEST/include"
CXXFLAGS=$CFLAGS


cd /tmp
 # zlib library build
  $DOWNLOADER $ZLIB
  tar zxvf zlib-1.2.11.tar.gz
  cd zlib-1.2.11/
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc STRIP=$HOST-strip RANLIB=$HOST-ranlib CXX=$HOST-g++ AR=$HOST-ar LD=$HOST-ld ./configure --prefix=$PREFIX --static
  make
  make install
 # expat library build
  cd /tmp
  $DOWNLOADER $EXPAT
  tar jxvf expat-2.2.0.tar.bz2
  cd expat-2.2.0/
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc CXX=$HOST-g++ ./configure --host=$HOST --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` --prefix=$PREFIX --enable-static=yes --enable-shared=no
  make
  make install
#
 # c-ares library build
  cd /tmp
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
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc CXX=$HOST-g++ ./Configure linux-armv4 $CFLAGS --prefix=$PREFIX shared zlib zlib-dynamic -D_GNU_SOURCE -D_BSD_SOURCE --with-zlib-lib=$LOCAL_DIR/lib --with-zlib-include=$LOCAL_DIR/include
  make 
  make install_sw
 # libssh2 library build
  cd /tmp
  $DOWNLOADER $SSH2
  tar zxvf libssh2-1.7.0.tar.gz
  cd libssh2-1.7.0/
  rm -rf $PREFIX/lib/pkgconfig/libssh2.pc
  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ LD_LIBRARY_PATH=$PREFIX/lib/ CC=$HOST-gcc CXX=$HOST-g++ AR=$HOST-ar RANLIB=$HOST-ranlib ./configure --host=$HOST --without-libgcrypt --with-openssl --without-wincng --prefix=$PREFIX --enable-static --disable-shared
  make
  make install
  cd /tmp
  rm -rf c-ares*
  rm -rf sqlite-autoconf*
  rm -rf zlib-*
  rm -rf expat-*
  rm -rf openssl-*
  rm -rf libssh2-*
 echo "all complete!"
