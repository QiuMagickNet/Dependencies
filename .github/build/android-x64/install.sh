#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update -y

apt-get install -y autoconf autopoint curl gettext git gperf libtool nasm pkg-config python3 python3-pip ragel texinfo unzip zip

pip3 install cmake==4.3.4
pip3 install meson==1.11.1
pip3 install ninja==1.13.0

# Install Android NDK
export ANDROID_NDK_VERSION="r28"
if [ ! -d "/opt/android-ndk" ]; then
  curl -sSL -o /tmp/android-ndk.zip "https://dl.google.com/android/repository/android-ndk-$ANDROID_NDK_VERSION-linux.zip"
  unzip -q /tmp/android-ndk.zip -d /opt
  mv /opt/android-ndk-$ANDROID_NDK_VERSION /opt/android-ndk
  rm -f /tmp/android-ndk.zip
fi
