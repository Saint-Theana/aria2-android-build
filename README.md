# aria2-android-build
Build android aria2 binary on linux(x86_64) using NDK.



Before building of binary,you should install ndk first.
using folowing command to install ndk-r15c:
``` sshell
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
```
