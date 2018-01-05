#!/bin/sh
mkdir /opt/NDK
cd /opt/NDK
apt install wget
wget https://dl.google.com/android/repository/android-ndk-r15c-linux-x86_64.zip
apt install unzip
unzip android-ndk-r15c-linux-x86_64.zip
rm android-ndk-r15c-linux-x86_64.zip

echo "export NDK=/opt/NDK/android-ndk-r15c
export ANDROID_HOME=/opt/NDK/android-ndk-r15c
export PATH=$ANDROID_HOME:$PATH" >> /etc/profile
source /etc/profile

$NDK/build/tools/make_standalone_toolchain.py \
   --arch arm64 --api 26 --stl=gnustl \
   --install-dir $ANDROID_HOME/toolchain

cd $ANDROID_HOME

mkdir -p usr/local/lib/pkgconfig
