#!/bin/sh
if [[ $ANDROID_HOME == "" ]];then
 echo "ANDROID_HOME not defined"
 exit 0
 fi
 
$ANDROID_HOME/build/tools/make_standalone_toolchain.py \
   --arch arm --api 16 --stl=gnustl \
   --install-dir $ANDROID_HOME/toolchain
