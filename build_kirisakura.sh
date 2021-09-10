#!/bin/bash

echo
echo "Clean Build Directory"
echo 

#make clean && make mrproper
#rm -rf ./out_cfi

echo
echo "Issue Build Commands"
echo

mkdir -p out_cfi
export ARCH=arm64
export SUBARCH=arm64
BASE_PATH=/home/miles/Android_Build/Clang_Google/linux-x86
BASE_PATH_GCC=/home/miles/Android_Build/GCC_Google_Arm64
BASE_PATH_GCC_32=/home/miles/Android_Build/GCC_Google_Arm32
export DTC_EXT=/home/miles/Downloads/DU_Tools/dtc-aosp
export CLANG_PATH=$BASE_PATH/clang-r428724/bin
export PATH=${CLANG_PATH}:${PATH}

export CLANG_TRIPLE=aarch64-linux-gnu-

export CROSS_COMPILE=$BASE_PATH_GCC/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_COMPAT=$BASE_PATH_GCC_32/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
export CROSS_COMPILE_ARM32=$BASE_PATH_GCC_32/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-

#export CROSS_COMPILE=$BASE_PATH/gas-linux-x86/aarch64-linux-gnu-
#export CROSS_COMPILE_ARM32=$BASE_PATH/gas-linux-x86/arm-linux-gnueabi-
#export CROSS_COMPILE_COMPAT=$CROSS_COMPILE_ARM32
#export LLVM_IAS=1

export CLANG_AR=$CLANG_PATH/llvm-ar
export CLANG_CC=$CLANG_PATH/clang
export CLANG_CCXX=$CLANG_PATH/clang++
export CLANG_LD=$CLANG_PATH/ld.lld
export CLANG_LDLTO=$CLANG_PATH/ld.lld
export CLANG_NM=$CLANG_PATH/llvm-nm
export CLANG_STRIP=$CLANG_PATH/llvm-strip
export CLANG_OC=$CLANG_PATH/llvm-objcopy
export CLANG_OD=$CLANG_PATH/llvm-objdump
export CLANG_OS=$CLANG_PATH/llvm-size
export CLANG_RE=$CLANG_PATH/llvm-readelf

export CC=$CLANG_CC
export HOST_CC=$CLANG_CC
export LD=$CLANG_LD

export ASUS_BUILD_PROJECT=ZS673KS

#export LLVM=1

echo "Generating binary conversions"
#cd binaries
#./convert
#cd ..

echo
echo "Set DEFCONFIG"
echo 

#make CC=$CLANG_CC LD=$CLANG_LD LDLTO=$CLANG_LD AR=$CLANG_AR NM=$CLANG_NM OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=out_cfi kirisakura_defconfig
make LLVM=1 CC=$CLANG_CC LD=$CLANG_LD AR=$CLANG_AR STRIP=$CLANG_STRIP OBJCOPY=$CLANG_OC NM=$CLANG_NM OBJDUMP=$CLANG_OD OBJSIZE=$CLANG_OS READELF=$CLANG_RE HOSTCC=$CLANG_CC HOSTCXX=$CLANG_CCXX HOSTAR=$CLANG_AR HOSTLD=$CLANG_LD O=out_cfi kirisakura_defconfig
#make O=out_cfi kirisakura_defconfig

echo
echo "Build The Good Stuff"
echo 

#make CC=$CLANG_CC LD=$CLANG_LD LDLTO=$CLANG_LD AR=$CLANG_AR NM=$CLANG_NM OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=out_cfi -j24
make LLVM=1 CC=$CLANG_CC LD=$CLANG_LD AR=$CLANG_AR STRIP=$CLANG_STRIP OBJCOPY=$CLANG_OC NM=$CLANG_NM OBJDUMP=$CLANG_OD OBJSIZE=$CLANG_OS READELF=$CLANG_RE HOSTCC=$CLANG_CC HOSTCXX=$CLANG_CCXX HOSTAR=$CLANG_AR HOSTLD=$CLANG_LD O=out_cfi -j24
#make O=out_cfi -j24
