#!/bin/bash
PWD=`pwd`
HOST_ARCH=`uname -m`
CROSS_NAME=arm-buildroot-linux-gnueabihf
TOOLCHAIN_FILE_SOURCE_NAME=toolchain.sh
TOOLCHAIN_CONFIG_FILE_TEMPLATE_NAME=config_template.sh
TOOLCHAIN_CMAKE_SAMPLE=cmake_sample.sh

TOOLCHAIN_PATH=${PWD}
CROSS_COMPILE=${CROSS_NAME}-
CROSS_NAME=${CROSS_NAME}

# Generate TOOLCHAIN_FILE_SOURCE_NAME file

rm -f  ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export TOOLCHAIN_PATH=${PWD}"  			>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export PATH=${PWD}/bin:${PATH}" 			>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export ARCH=arm" 							>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export CROSS_COMPILE=${CROSS_NAME}-" 		>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export CROSS_NAME=${CROSS_NAME}" 			>> ${TOOLCHAIN_FILE_SOURCE_NAME}

echo "" >> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "# TARGET build tools" >> ${TOOLCHAIN_FILE_SOURCE_NAME}

echo "export CC=${CROSS_COMPILE}gcc"			>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export GCC=${CROSS_COMPILE}gcc"			>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export CPP=${CROSS_COMPILE}cpp"			>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export CXX=${CROSS_COMPILE}g++"			>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export NM=${CROSS_COMPILE}nm"				>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export AR=${CROSS_COMPILE}ar"				>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export AS=${CROSS_COMPILE}as"				>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export LD=${CROSS_COMPILE}ld"				>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export FC=${CROSS_COMPILE}gfortran"		>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export F77=${CROSS_COMPILE}gfortran"		>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export RANLIB=${CROSS_COMPILE}ranlib"		>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export READELF=${CROSS_COMPILE}readelf"	>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export STRIP=${CROSS_COMPILE}objcopy"		>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export OBJDUMP=${CROSS_COMPILE}objdump"	>> ${TOOLCHAIN_FILE_SOURCE_NAME}

echo "" >> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "# Default TARGET build tools" >> ${TOOLCHAIN_FILE_SOURCE_NAME}

echo "export DEFAULT_ASSEMBLER=${AS}"			>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "export DEFAULT_LINKER=${LD}"				>> ${TOOLCHAIN_FILE_SOURCE_NAME}

echo "" >> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "# HOST build tools" >> ${TOOLCHAIN_FILE_SOURCE_NAME}

echo 'export AR_FOR_BUILD="/usr/bin/ar"'		>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo 'export AS_FOR_BUILD="/usr/bin/as"'		>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo 'export CC_FOR_BUILD="/usr/bin/gcc"'		>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo 'export GCC_FOR_BUILD="/usr/bin/gcc"'		>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo 'export CXX_FOR_BUILD="/usr/bin/g++"'		>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo 'export LD_FOR_BUILD="/usr/bin/ld"'		>> ${TOOLCHAIN_FILE_SOURCE_NAME}

echo "" >> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo "# TARGET build flags" >> ${TOOLCHAIN_FILE_SOURCE_NAME}

echo 'export CPPFLAGS_FOR_BUILD="-I${TOOLCHAIN_PATH}/include"'			>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo 'export CFLAGS_FOR_BUILD="-O2 -I${TOOLCHAIN_PATH}/include"'		>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo 'export CXXFLAGS_FOR_BUILD="-O2 -I${TOOLCHAIN_PATH}/include"'		>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo 'export LDFLAGS_FOR_BUILD="-L${TOOLCHAIN_PATH}/lib -Wl,-rpath,${TOOLCHAIN_PATH}/lib"'	>> ${TOOLCHAIN_FILE_SOURCE_NAME}
echo 'export FCFLAGS_FOR_BUILD=""'										>> ${TOOLCHAIN_FILE_SOURCE_NAME}


# Generate TOOLCHAIN_CONFIG_FILE_TEMPLATE_NAME file

rm -f  ${TOOLCHAIN_CONFIG_FILE_TEMPLATE_NAME}
echo "#!/bin/bash" 							>> ${TOOLCHAIN_CONFIG_FILE_TEMPLATE_NAME}
echo "./configure --target=${CROSS_NAME} --host=${CROSS_NAME} --build=${HOST_ARCH}-pc-linux-gnu --prefix=/usr --exec-prefix=/usr --sysconfdir=/etc --localstatedir=/var --program-prefix="" --with-yielding-select=yes --disable-debugging --disable-static --enable-shared  --with-shared --enable-ipv6" >> ${TOOLCHAIN_CONFIG_FILE_TEMPLATE_NAME}


# Generate TOOLCHAIN_CMAKE_SAMPLE file

rm -f  ${TOOLCHAIN_CMAKE_SAMPLE}
echo "#!/bin/bash" 							>> ${TOOLCHAIN_CMAKE_SAMPLE}

echo 'cmake -G"Unix Makefiles" -BBuild/ArmLinux -DBAREMETAL_ARM_TOOLCHAIN_PATH='${TOOLCHAIN_PATH}'/bin/ -DCMAKE_TOOLCHAIN_FILE=armtoolchain.cmake  -DCMAKE_BUILD_TYPE="Release"' >> ${TOOLCHAIN_CMAKE_SAMPLE}
echo "make -j`nproc`" >> ${TOOLCHAIN_CMAKE_SAMPLE}


chmod +x ${TOOLCHAIN_FILE_SOURCE_NAME}
chmod +x ${TOOLCHAIN_CONFIG_FILE_TEMPLATE_NAME}
chmod +x ${TOOLCHAIN_CMAKE_SAMPLE}
source ${TOOLCHAIN_FILE_SOURCE_NAME} 
check_ok=`which ${CROSS_COMPILE}gcc`
if [ -z "${check_ok}" ]; then
	echo "install toolchain fail"
else
	echo "toolchain install on ${check_ok}"
	echo "Run command 'source ${TOOLCHAIN_FILE_SOURCE_NAME}'"
	echo "${TOOLCHAIN_CONFIG_FILE_TEMPLATE_NAME} - sample template using with ./config utils"
	echo "${TOOLCHAIN_CMAKE_SAMPLE}    - sample template using cmake utils"
fi
