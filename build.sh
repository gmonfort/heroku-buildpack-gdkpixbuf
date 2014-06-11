#!/bin/bash

SRC_DIR=~/src
VENDOR_DIR=~/app/vendor
OUT_DIR=~/out

[ ! -d $SRC_DIR  ] && mkdir $SRC_DIR
[ ! -d $OUT_DIR  ] && mkdir $OUT_DIR
[ ! -d $VENDOR_DIR  ] && mkdir $VENDOR_DIR

function display() {
  echo -e "\n----->" $*
}

function abort() {
  echo $* ; exit 1
}

function indent() {
  sed -u "s/^/       /"
}

function prepare_package() {
  name="$1"
  cd $VENDOR_DIR/$name
  tar zcf $OUT_DIR/$name.tar.gz .
  cd $SRC_DIR
  echo "Installed: $name" | indent
}

cd $SRC_DIR

# curl -LO http://download.osgeo.org/libtiff/tiff-4.0.3.tar.gz
# curl -LO http://downloads.sourceforge.net/libpng/libpng-1.6.11.tar.xz
# curl -LO http://www.nasm.us/pub/nasm/releasebuilds/2.11.05/nasm-2.11.05.tar.xz
# curl -LO http://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-1.3.1.tar.gz
# curl -LO ftp://sourceware.org/pub/libffi/libffi-3.1.tar.gz
# curl -LO http://pkgconfig.freedesktop.org/releases/pkg-config-0.28.tar.gz
# curl -LO http://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.tar.gz
# curl -LO http://ftp.gnome.org/pub/gnome/sources/glib/2.40/glib-2.40.0.tar.xz
# curl -LO http://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.30/gdk-pixbuf-2.30.8.tar.xz

## Building

# libtiff
tar xzf tiff-4.0.3.tar.gz
cd tiff-4.0.3
NAME=tiff-4.0.3
PREFIX=$VENDOR_DIR/$NAME
sed -i '/glDrawPixels/a glFlush();' tools/tiffgt.c &&
./configure --prefix=$PREFIX --disable-static &&
  make && sudo make install
prepare_package $NAME

#libpng
tar xJf libpng-1.6.11.tar.xz
cd libpng-1.6.11
NAME=libpng-1.6.11
PREFIX=$VENDOR_DIR/$NAME
./configure --prefix=$PREFIX --disable-static &&
  make && sudo make install
prepare_package $NAME

# NASM
tar xJf nasm-2.11.05.tar.xz
cd nasm-2.11.05
NAME=nasm-2.11.05
PREFIX=$VENDOR_DIR/$NAME
./configure --prefix=$PREFIX &&
  make && sudo make install
prepare_package $NAME

# libjpeg-turbo
tar xzf libjpeg-turbo-1.3.1.tar.gz
cd libjpeg-turbo-1.3.1
NAME=libjpeg-turbo-1.3.1
PREFIX=$VENDOR_DIR/$NAME
sed -i -e '/^docdir/     s:$:/libjpeg-turbo-1.3.1:' \
       -e '/^exampledir/ s:$:/libjpeg-turbo-1.3.1:' Makefile.in &&
./configure --prefix=$PREFIX        \
            --mandir=/usr/share/man \
            --with-jpeg8            \
            --disable-static &&
make && sudo make install
prepare_package $NAME

# libffi
tar xzf libffi-3.1.tar.gz
cd libffi-3.1
NAME=libffi-3.1
PREFIX=$VENDOR_DIR/$NAME
sed -e '/^includesdir/ s:$(libdir)/@PACKAGE_NAME@-@PACKAGE_VERSION@/include:$(includedir):' \
    -i include/Makefile.in &&
sed -e '/^includedir/ s:${libdir}/@PACKAGE_NAME@-@PACKAGE_VERSION@/include:@includedir@:' \
    -e 's/^Cflags: -I${includedir}/Cflags:/' \
    -i libffi.pc.in        &&
./configure --prefix=$PREFIX --disable-static &&
make && sudo make install
prepare_package $NAME

# pkg-config
tar xzf pkg-config-0.28.tar.gz
cd pkg-config-0.28
NAME=pkg-config-0.28
PREFIX=$VENDOR_DIR/$NAME
./configure --prefix=$PREFIX --with-internal-glib &&
make && sudo make install
prepare_package $NAME

# gettext
tar xzf gettext-0.19.tar.gz
cd gettext-0.19
NAME=gettext-0.19
PREFIX=$VENDOR_DIR/$NAME
./configure --prefix=$PREFIX &&
make && sudo make install
prepare_package $NAME

# Glib
tar xJf glib-2.40.0.tar.xz
cd glib-2.40.0
NAME=glib-2.40.0
PREFIX=$VENDOR_DIR/$NAME
# ./configure --prefix=$PREFIX --with-pcre=system &&
./configure --prefix=$PREFIX &&
make && sudo make install
prepare_package $NAME

export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH

# gdk-pixbuf
tar xJf gdk-pixbuf-2.30.8.tar.xz
cd gdk-pixbuf-2.30.8
NAME=gdk-pixbuf-2.30.8
PREFIX=$VENDOR_DIR/$NAME
./configure --prefix=$PREFIX --with-x11 &&
make && sudo make install
prepare_package $NAME

