#!/bin/bash
#
# This script will setup and install ethminer with CUDA support
# Built for AWS GPU EC2 instances running Ubuntu 14.04 (ami-772aa961)
#
# Taped together by Mike Heijmans (@parabuzzle) with information from the cpp-ethereum project
#
# PUBLIC DOMAIN LICENSE
# I dedicate any and all copyright interest in this software to the
# public domain. I make this dedication for the benefit of the public at
# large and to the detriment of my heirs and successors. I intend this
# dedication to be an overt act of relinquishment in perpetuity of all
# present and future rights to this software under copyright law.

echo "Starting Setup"
echo -e "###\n\n"

echo "  - Get the Cuda package"
rm -rf cuda-repo-ubuntu1404_7.5-18_amd64.deb
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_7.5-18_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1404_7.5-18_amd64.deb

echo "  - Prepare apt-get"
sudo apt-get -y install software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update

echo "  - Install the required libraries"
sudo apt-get install unzip cmake libcryptopp-dev gcc-4.8 g++-4.8 libleveldb-dev libjsoncpp-dev libjson-rpc-cpp-dev libboost-all-dev libgmp-dev libreadline-dev libcurl4-gnutls-dev ocl-icd-libopencl1 opencl-headers mesa-common-dev libmicrohttpd-dev build-essential cuda -y

echo "  - Get the ethminer code"
rm -rf cpp-ethereum-master master.zip
wget https://github.com/Genoil/cpp-ethereum/archive/master.zip
unzip master.zip

echo "  - Prepare to build"
cd cpp-ethereum-master/
rm -rf build
mkdir build
cd build

echo " - Build ethminer"
export CC=/usr/bin/gcc-4.8
export CXX=/usr/bin/g++-4.8
export CXXFLAGS=-std=c++11
export CUDADIR=/usr/local/cuda
export PATH=/usr/local/cuda/bin:$PATH
cmake -DBUNDLE=cudaminer -DCOMPUTE=50 -DCUDA_NVCC_FLAGS='-std=c++11' ..
make -j8

echo "  - Install ehtminer"
sudo cp ethminer/ethminer /usr/bin/ethminer
sudo chmod +x /usr/bin/ethminer
echo -e "Install Complete\n\n"
echo -e "  ====================================================================================="
echo -e "  *                            Your miner is ready to go                              *"
echo -e "  *                                                                                   *"
echo -e "  *    Please consider a donation in ETH: 0x5772f7b44aebefbcbfdebbc41cc5bab45c9a8dba  *"
echo -e "  =====================================================================================\n"
echo "You can now run 'ethminer -U --list-devices' to see the CUDA devices available"
