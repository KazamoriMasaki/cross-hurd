#!/bin/sh

. ./config.sh

BINUTILS_URL=http://mirrors.ustc.edu.cn/gnu/binutils/$BINUTILS_PKG
GCC_URL=http://mirrors.ustc.edu.cn/gnu/gcc/gcc-"$GCC_VERSION"/"$GCC_PKG"
GMP_URL=http://mirrors.ustc.edu.cn/gnu/gmp/"$GMP_PKG"
MPC_URL=http://mirrors.ustc.edu.cn/gnu/mpc/"$MPC_PKG"
MPFR_URL=http://mirrors.ustc.edu.cn/gnu/mpfr/"$MPFR_PKG"

FLEX_URL=https://github.com/westes/flex/releases/download/v$FLEX_VERSION/$FLEX_PKG
ZLIB_URL=http://zlib.net/"$ZLIB_PKG"
BASH_URL=http://mirrors.ustc.edu.cn/gnu/bash/"$BASH_PKG"
COREUTILS_URL=http://mirrors.ustc.edu.cn/gnu/coreutils/"$COREUTILS_PKG"
E2FSPROGS_URL=https://mirror.bjtu.edu.cn/kernel/linux/kernel/people/tytso/e2fsprogs/v"$E2FSPROGS_VERSION"/"$E2FSPROGS_PKG"
PKGCONFIGLITE_URL=http://downloads.sourceforge.net/project/pkgconfiglite/"$PKGCONFIGLITE_VERSION"/"$PKGCONFIGLITE_PKG"
LIBUUID_URL=http://downloads.sourceforge.net/project/libuuid/"$LIBUUID_PKG"
UTIL_LINUX_URL=https://mirror.bjtu.edu.cn/kernel/linux/utils/util-linux/v"$UTIL_LINUX_VERSION"/"$UTIL_LINUX_PKG"
GRUB_URL=http://mirrors.ustc.edu.cn/gnu/grub/"$GRUB_PKG"
SHADOW_URL=https://github.com/shadow-maint/shadow/releases/download/"$SHADOW_VERSION"/"$SHADOW_PKG"
SED_URL=http://mirrors.ustc.edu.cn/gnu/sed/"$SED_PKG"
NCURSES_URL=http://mirrors.ustc.edu.cn/gnu/ncurses/"$NCURSES_PKG"
VIM_URL=ftp://ftp.vim.org/pub/vim/unix/"$VIM_PKG"
GPG_ERROR_URL=ftp://ftp.gnupg.org/gcrypt/libgpg-error/"$GPG_ERROR_PKG"
GCRYPT_URL=ftp://ftp.gnupg.org/gcrypt/libgcrypt/"$GCRYPT_PKG"
MAKE_URL=http://mirrors.ustc.edu.cn/gnu/make/"$MAKE_PKG"

unpack () {
   if [ -d "$3" ]; then
      return 0
   fi
   print_info "unpacking $2" &&
   tar $1 $2
}

download () {
   if [ -f $1 ]; then
      return 0
   fi
   wget -c $2
}

download_gnumach () {
   if [ -d gnumach ]; then
      cd gnumach && git pull && cd .. &&
      return 0
   fi
   git clone https://git.savannah.gnu.org/git/hurd/gnumach.git
}

download_mig () {
   if [ -d mig ]; then
      cd mig && git pull && cd .. &&
      return 0
   fi
   git clone https://git.savannah.gnu.org/git/hurd/mig.git
}

download_hurd () {
   if [ -d hurd ]; then
      cd hurd && git pull && cd .. &&
      return 0
   fi
   git clone https://git.savannah.gnu.org/git/hurd/hurd.git
}

apply_patch() {
   print_info "Using patch $1 (level: $2)"
   patch -Np$2 < $1 || exit 1
}

apply_patch_optional() {
   print_info "Using patch $1 (level: $2)"
   patch -Np$2 < $1
}

download_glibc () {
   if [ -d glibc ]; then
      cd glibc && git pull && cd ..
      return 0
   fi
   git clone https://gitee.com/Aloxaf/glibc.git &&
   cd glibc &&
   apply_patch $SCRIPT_DIR/patches/glibc/tg-mach-hurd-link.diff 1 &&
   apply_patch $SCRIPT_DIR/patches/glibc/unsubmitted-clock_t_centiseconds.diff 1 &&
   apply_patch $SCRIPT_DIR/patches/glibc/unsubmitted-prof-eintr.diff 1 &&
   apply_patch $SCRIPT_DIR/patches/glibc/tg-bits_atomic.h_multiple_threads.diff 1 &&
   cd ..
}

unpack_gcc () {
   unpack zxf $GCC_PKG $GCC_SRC &&
   cd $GCC_SRC &&
   (if [ "$CPU" = "i586" ]; then
    apply_patch $SCRIPT_DIR/patches/gcc/i586/specs.patch 1
   fi) &&
   (if [ "$CPU" = "x86_64" ]; then
    apply_patch $SCRIPT_DIR/patches/gcc/x86_64/config.patch 1 &&
    apply_patch $SCRIPT_DIR/patches/gcc/x86_64/gnu64.patch 1 &&
    apply_patch $SCRIPT_DIR/patches/gcc/x86_64/libgcc.patch 1
   fi) &&
   cd ..
}

download_gcc () {
   download $GCC_PKG $GCC_URL &&
   if [ -d "$GCC_SRC" ]; then
      return 0
   fi
   unpack_gcc
}

unpack_gmp () {
   unpack xjf $GMP_PKG $GMP_SRC
}

download_gmp () {
   download $GMP_PKG $GMP_URL
   if [ -d "$GMP_SRC" ]; then
      return 0
   fi
   unpack_gmp
}

unpack_mpfr () {
   unpack zxf $MPFR_PKG $MPFR_SRC
}

download_mpfr() {
   download $MPFR_PKG $MPFR_URL &&
   if [ -d "$MPFR_SRC" ]; then
      return 0
   fi
   unpack_mpfr
}

unpack_mpc () {
   unpack zxf $MPC_PKG $MPC_SRC
}

download_mpc() {
   download $MPC_PKG $MPC_URL &&
   if [ -d "$MPC_SRC" ]; then
      return 0
   fi
   unpack_mpc
}


download_binutils () {
   download $BINUTILS_PKG $BINUTILS_URL &&
   if [ -d "$BINUTILS_SRC" ]; then
      return 0
   fi
   unpack jxf $BINUTILS_PKG $BINUTILS_SRC &&
   cd $BINUTILS_SRC &&
   (if [ $CPU = "x86_64" ]; then
     apply_patch $SCRIPT_DIR/patches/binutils/x86_64/binutils-bfd-x86_64-gnu.patch 1 &&
     apply_patch $SCRIPT_DIR/patches/binutils/x86_64/binutils-ld-x86_64-gnu.patch 1
   fi) &&
   cd ..
 }

download_coreutils () {
   download $COREUTILS_PKG $COREUTILS_URL &&
   if [ ! -d "$COREUTILS_SRC" ]; then
	   unpack Jxf $COREUTILS_PKG $COREUTILS_SRC
   fi
}

download_sed () {
	download $SED_PKG $SED_URL &&
	if [ -d "$SED_SRC" ]; then
		return 0
	fi
	unpack xf $SED_PKG $SED_SRC
}

download_ncurses () {
  download $NCURSES_PKG $NCURSES_URL &&
  if [ -d "$NCURSES_SRC" ]; then
    return 0
  fi
  unpack zxf $NCURSES_PKG $NCURSES_SRC
}

download_vim () {
  download $VIM_PKG $VIM_URL &&
  if [ -d "vim$VIM_BASE_VERSION" ]; then
    return 0
  fi
  unpack jxf $VIM_PKG $VIM_SRC
}

download_gpg_error () {
  download $GPG_ERROR_PKG $GPG_ERROR_URL &&
  if [ -d "$GPG_ERROR_SRC" ]; then
    return 0
  fi
  unpack jxf $GPG_ERROR_PKG $GPG_ERROR_SRC &&
  cd $GPG_ERROR_SRC &&
  (for p in $SCRIPT_DIR/patches/libgpg-error/*; do
    apply_patch $p 1
  done) &&
  cd ..
}

download_gcrypt () {
  download $GCRYPT_PKG $GCRYPT_URL &&
  if [ -d "$GCRYPT_SRC" ]; then
    return 0
  fi
  unpack jxf $GCRYPT_PKG $GCRYPT_SRC
}

download_make () {
  download $MAKE_PKG $MAKE_URL &&
  if [ -d "$MAKE_SRC" ]; then
    return 0
  fi
  unpack xf $MAKE_PKG $MAKE_SRC
}

