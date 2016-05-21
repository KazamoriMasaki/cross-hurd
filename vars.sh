. ./config.sh

export AR=gar
export SCRIPT_DIR=$PWD
export SYSTEM=$PWD/tmp
export ROOT=/cross-tools
export SYS_ROOT=/tools
export TARGET=$CPU-pc-gnu
export HOST="$(echo $MACHTYPE | sed "s/$(echo $MACHTYPE | cut -d- -f2)/cross/g")"
export PATH=$ROOT/bin:$PATH

if [ ! -z "$CCACHE_DIRECTORY" ]; then
   export PATH=$CCACHE_DIRECTORY:$PATH
fi

# Package versions.
BINUTILS_VERSION=2.25.1
GCC_VERSION=5.3.0
FLEX_VERSION=2.6.0
ZLIB_VERSION=1.2.8
BASH_VERSION=4.3.30
COREUTILS_VERSION=8.24
E2FSPROGS_VERSION=1.42.13
PKGCONFIGLITE_VERSION=0.28-1
LIBUUID_VERSION=1.0.3
UTIL_LINUX_BASE_VERSION=2.27
UTIL_LINUX_VERSION="$UTIL_LINUX_BASE_VERSION".1
GRUB_VERSION=2.00
SHADOW_VERSION=4.2.1
SED_VERSION=4.2.2
GMP_VERSION=6.1.0
MPFR_VERSION=3.1.4
MPC_VERSION=1.0.3
NCURSES_VERSION=6.0
VIM_BASE_VERSION=74
VIM_VERSION=7.4
# Mach, Hurd and Glibc are all taken from the Git repository.

BINUTILS_SRC=binutils-"$BINUTILS_VERSION"
BINUTILS_PKG="${BINUTILS_SRC}.tar.bz2"
GCC_SRC=gcc-"$GCC_VERSION"
GCC_PKG="$GCC_SRC".tar.bz2
GNUMACH_SRC=gnumach
GNUMIG_SRC=mig
HURD_SRC=hurd
GLIBC_SRC=glibc
FLEX_SRC=flex-"$FLEX_VERSION"
FLEX_PKG="$FLEX_SRC".tar.bz2
ZLIB_SRC=zlib-"$ZLIB_VERSION"
ZLIB_PKG="$ZLIB_SRC".tar.gz
BASH_SRC=bash-"$BASH_VERSION"
BASH_PKG="$BASH_SRC".tar.gz
COREUTILS_SRC=coreutils-"$COREUTILS_VERSION"
COREUTILS_PKG="$COREUTILS_SRC".tar.xz
E2FSPROGS_SRC=e2fsprogs-"$E2FSPROGS_VERSION"
E2FSPROGS_PKG="$E2FSPROGS_SRC".tar.gz
PKGCONFIGLITE_SRC=pkg-config-lite-"$PKGCONFIGLITE_VERSION"
PKGCONFIGLITE_PKG="$PKGCONFIGLITE_SRC".tar.gz
LIBUUID_SRC=libuuid-"$LIBUUID_VERSION"
LIBUUID_PKG="$LIBUUID_SRC".tar.gz
UTIL_LINUX_SRC=util-linux-"$UTIL_LINUX_VERSION"
UTIL_LINUX_PKG="$UTIL_LINUX_SRC".tar.gz
GRUB_SRC=grub-"$GRUB_VERSION"
GRUB_PKG="$GRUB_SRC".tar.gz
SHADOW_SRC=shadow-"$SHADOW_VERSION"
SHADOW_PKG="$SHADOW_SRC".tar.xz
SED_SRC=sed-"$SED_VERSION"
SED_PKG="$SED_SRC".tar.gz
GMP_SRC=gmp-"$GMP_VERSION"
GMP_PKG="${GMP_SRC}".tar.bz2
MPFR_SRC=mpfr-"$MPFR_VERSION"
MPFR_PKG="${MPFR_SRC}".tar.bz2
MPC_SRC=mpc-"$MPC_VERSION"
MPC_PKG="${MPC_SRC}".tar.gz
NCURSES_SRC=ncurses-"$NCURSES_VERSION"
NCURSES_PKG="${NCURSES_SRC}".tar.gz
VIM_SRC=vim-"$VIM_VERSION"
VIM_PKG="$VIM_SRC".tar.bz2

print_info ()
{
   echo "* $*"
}

