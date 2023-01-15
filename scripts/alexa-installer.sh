#!/bin/bash

set -o errexit

scripts_dir="$(dirname "${BASH_SOURCE[0]}")"
GIT_DIR="$(realpath $(dirname ${BASH_SOURCE[0]})/..)"

# make sure we're running as the owner of the checkout directory
RUN_AS="$(ls -ld "$scripts_dir" | awk 'NR==1 {print $3}')"
if [ "$USER" != "$RUN_AS" ]
then
    echo "This script must run as $RUN_AS, trying to change user..."
    exec sudo -u $RUN_AS $0
fi

echo ""
echo "Installing Amazon Alexa.........."
echo ""
echo "This could take a while grab a coffee or beer........."
# Create the SDK folder structure
cd $HOME
mkdir sdk-folder
cd sdk-folder
mkdir sdk-build sdk-source sdk-install db
# Update the Raspberry Pi package list
sudo apt-get update && sudo apt-get upgrade
# Install the core SDK dependencies
sudo apt-get -y install \
git gcc cmake build-essential libsqlite3-dev libcurl4-openssl-dev libfaad-dev \
libgtest-dev libssl-dev libsoup2.4-dev libgcrypt20-dev libgstreamer-plugins-bad1.0-dev \
libnghttp2-dev nghttp2 gstreamer1.0-plugins-good libasound2-dev doxygen portaudio19-dev
# Clone the SDK into the sdk-source folder
cd $HOME/sdk-folder/sdk-source
git clone --single-branch https://github.com/alexa/avs-device-sdk.git
# Find the path to the PortAudio library
PORTAUDIO_LIB_PATH=$(find -P /usr/lib -name libportaudio.so)
# Build the SDK
cd $HOME/sdk-folder/sdk-build
cmake $HOME/sdk-folder/sdk-source/avs-device-sdk \
    -DGSTREAMER_MEDIA_PLAYER=ON \
    -DPORTAUDIO=ON \
    -DPKCS11=OFF \
    -DPORTAUDIO_LIB_PATH=$PORTAUDIO_LIB_PATH \
    -DPORTAUDIO_INCLUDE_DIR=/usr/include \
    -DCMAKE_BUILD_TYPE=DEBUG
# Build the SDK Sample App
make SampleApp
# Set up a SDK configuration file
cd $HOME/sdk-folder/sdk-source/avs-device-sdk/tools/Install
cp $HOME/config.json .
bash $HOME/sdk-folder/sdk-source/avs-device-sdk/tools/Install/genConfig.sh \
config.json \
12345 \
$HOME/sdk-folder/db \
$HOME/sdk-folder/sdk-source/avs-device-sdk \
$HOME/sdk-folder/sdk-build/Integration/AlexaClientSDKConfig.json \
-DSDK_CONFIG_MANUFACTURER_NAME="raspberrypi" \
-DSDK_CONFIG_DEVICE_DESCRIPTION="raspberrypi"
echo "Finished installing Alexa.........."
