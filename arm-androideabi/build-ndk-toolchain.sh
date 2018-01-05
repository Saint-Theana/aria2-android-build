#!/bin/sh
mkdir -p /opt/NDK
cd /opt/NDK
apt install wget
wget https://dl.google.com/android/repository/android-ndk-r14b-linux-x86_64.zip
apt install unzip
unzip android-ndk-r14b-linux-x86_64.zip
rm android-ndk-r14b-linux-x86_64.zip

echo "export NDK=/opt/NDK/android-ndk-r14b
export ANDROID_HOME=/opt/NDK/android-ndk-r14b
export PATH=$ANDROID_HOME:$PATH" >> /etc/profile
source /etc/profile


if [[ $ANDROID_HOME == "" ]];then
 echo "ANDROID_HOME not defined"
 exit 0
 fi
 
$ANDROID_HOME/build/tools/make_standalone_toolchain.py \
   --arch arm --api 16 --stl=gnustl \
   --install-dir $ANDROID_HOME/toolchain


cd $ANDROID_HOME

mkdir -p usr/local/lib/pkgconfig
