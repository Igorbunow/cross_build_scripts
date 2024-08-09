#!/bin/bash
./configure --target=arm-buildroot-linux-gnueabihf --host=arm-buildroot-linux-gnueabihf --build=x86_64-pc-linux-gnu --prefix=/usr --exec-prefix=/usr --sysconfdir=/etc --localstatedir=/var --program-prefix= --with-yielding-select=yes --disable-debugging --disable-static --enable-shared  --with-shared --enable-ipv6
