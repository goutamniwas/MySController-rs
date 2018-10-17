#!/bin/bash -e
# Manually build OpenSSL. The openssl crate requires 1.0.2+, but Travis CI
# only includes 1.0.0.
wget https://www.openssl.org/source/openssl-1.1.1.tar.gz
tar xzf openssl-1.1.1.tar.gz
cd openssl-1.1.1
./config --prefix=/usr/local shared
make >/dev/null
sudo make install >/dev/null
sudo ldconfig
cd ..
sudo apt-get install -qq gcc-arm-linux-gnueabihf
# rustup target add armv7-unknown-linux-gnueabihf

cargo test
# cargo build --release --target x86_64-unknown-linux-gnu

# wget https://www.openssl.org/source/openssl-1.0.1t.tar.gz
# tar xzf openssl-1.0.1t.tar.gz
# export MACHINE=armv7
# export ARCH=arm
# export CC=arm-linux-gnueabihf-gcc
# cd openssl-1.0.1t && ./config shared && make && cd -
# sudo dpkg --add-architecture armhf
# sudo apt-get update

# sudo apt-get install libudev-dev:armhf

# export OPENSSL_LIB_DIR=/home/travis/build/tsathishkumar/MySController-rs/openssl-1.1.1
# export OPENSSL_INCLUDE_DIR=/home/travis/build/tsathishkumar/MySController-rs/openssl-1.1.1/include

# PKG_CONFIG_ALLOW_CROSS=1 cargo build --release --target armv7-unknown-linux-gnueabihf
cargo deb --target x86_64-unknown-linux-gnu 
#--variant=x86_64
# cargo deb --no-build --variant=armv7