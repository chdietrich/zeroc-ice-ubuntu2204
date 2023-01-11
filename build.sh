#!/bin/sh

set -eux

ICE_VERSION=${1:-"3.6.5"}
BUILD=${BRANCH_NAME:-dev}
TARGET_NAME=ice-$ICE_VERSION-$BUILD

# Enable multi-thread compiling
export MAKEFLAGS="-j$(nproc)"

# Build Ice cpp from source
wget -qO- https://github.com/zeroc-ice/ice/archive/v$ICE_VERSION.tar.gz | tar xz
cd ice-$ICE_VERSION/cpp

CXXFLAGS=-Wno-error make --silent prefix=/opt/$TARGET_NAME
make install --silent prefix=/opt/$TARGET_NAME

tar -zcf /dist/$TARGET_NAME-ubuntu2204-amd64.tar.gz -C /opt $TARGET_NAME

# Zeroc IcePy
# TODO: is it possible to rename the wheel to indicate it's only for Ubuntu?
pip3 download "zeroc-ice==$ICE_VERSION"
tar -zxf "zeroc-ice-$ICE_VERSION.tar.gz"
cd "zeroc-ice-$ICE_VERSION"
python3 setup.py bdist_wheel

cp dist/* /dist/
