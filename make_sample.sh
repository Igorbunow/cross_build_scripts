#!/bin/bash

STAGING_DIR=temp make CC=arm-buildroot-linux-gnueabihf-gcc LD=arm-buildroot-linux-gnueabihf-ld AR=arm-buildroot-linux-gnueabihf-ar OBJDUMP=arm-buildroot-linux-gnueabihf-objdump NM=arm-buildroot-linux-gnueabihf-nm STRIP=arm-buildroot-linux-gnueabihf-objcopy CROSS_COMPILE_PLATFORM=arm-buildroot-linux-gnueabihf
