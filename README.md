Ethereum Mining in the Cloud
===

So you want to use the cloud to mine ether? This repo is a collection of scripts to get you going.

## TL;DR

  * Create a GPU instance running Ubuntu 14.04
  * Login and copy the `setup_ethminer_cuda_ubuntu-14.04.sh` from this repo to the machine
  * run `bash setup_ethminer_cuda_ubuntu-14.04.sh`
  * bob's your uncle! (run `ethminer` to mine some sweet ether)

## A few things to know

**Ethereum mining on GPU in the cloud (as of the last edit of this README) is not profitable!**

Doing this is purely academic and for fun. With the price of ether going up, you may find that losses today translate to profit tomorrow, but don't take this as any advice of the financial nature. You're on your own there bud!

The version of `ethminer` that is installed with these scripts does not support CPU mining and therefore will not run without a GPU to run the work on. It also support statrum mining so you can join a pool (which is a recommended way of mining ether in the cloud)
