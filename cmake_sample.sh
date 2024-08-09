#!/bin/bash
cmake -G"Unix Makefiles" -BBuild/ArmLinux -DBAREMETAL_ARM_TOOLCHAIN_PATH=/media/backup_new/BUILD/build_root_new/buildroot/output/host/bin/ -DCMAKE_TOOLCHAIN_FILE=armtoolchain.cmake  -DCMAKE_BUILD_TYPE="Release"
make -j40
