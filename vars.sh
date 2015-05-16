export CC=x86_64-apple-darwin14.0.0-gcc-4.9
export CXX=x86_64-apple-darwin14.0.0-g++-4.9
export PROCS=1
export SCRIPT_DIR=$PWD
export ROOT=$PWD/tmp
export SYS_ROOT=$ROOT/sys
export TARGET=i586-pc-gnu
export HOST="$(echo $MACHTYPE | sed "s/$(echo $MACHTYPE | cut -d- -f2)/cross/g")"

# Package versions.
BINUTILS_VERSION=2.25
GCC_VERSION=4.9.2
# Mach, Hurd and Glibc are all taken from the Git repository.

BINUTILS_SRC=binutils-"$BINUTILS_VERSION"
BINUTILS_PKG="${BINUTILS_SRC}.tar.bz2"
GCC_SRC=gcc-"$GCC_VERSION"
GCC_PKG="$GCC_SRC".tar.bz2
GNUMACH_SRC=gnumach
GNUMIG_SRC=mig
HURD_SRC=hurd
GLIBC_SRC=glibc
