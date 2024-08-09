# cross_build_scripts
cross_build_scripts


1) Copy all scripts into toolchain folder, ed: /home/user/work/cl_buildroot/output/host/bin/arm-buildroot-linux-gnueabihf-gcc

```bash
$ls
arm-buildroot-linux-gnueabihf  
bin
doc
include
lib
libexec
sbin
etc
lib64
share
usr
```

2) run `./install_toolchain.sh`
3) 
```bash
source toolchain.sh
```

4) test it:
```bash
echo $ARCH
arm
```

config_template.sh - sample template using with ./config utils
cmake_sample.sh    - sample template using cmake utils
make_sample.sh     - sample template using make util. In some cases may be simple make
