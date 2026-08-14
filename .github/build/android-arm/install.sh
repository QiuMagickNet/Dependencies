#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update -y

sudo apt-get install -y autoconf autopoint curl gettext git gperf libtool nasm pkg-config python3 python3-pip ragel texinfo unzip zip

# sudo pip3 install --break-system-packages --upgrade pip # skip: pip 24.0 from debian cannot be re-installed
sudo pip3 install --break-system-packages cmake==4.3.4
sudo pip3 install --break-system-packages meson==1.11.1
sudo pip3 install --break-system-packages ninja==1.13.0

# Install Android NDK
export ANDROID_NDK_VERSION="r28"
if [ ! -d "/opt/android-ndk" ]; then
  sudo curl -sSL -o /tmp/android-ndk.zip "https://dl.google.com/android/repository/android-ndk-$ANDROID_NDK_VERSION-linux.zip"
  sudo unzip -q /tmp/android-ndk.zip -d /opt
  sudo mv /opt/android-ndk-$ANDROID_NDK_VERSION /opt/android-ndk
  sudo rm -f /tmp/android-ndk.zip
fi