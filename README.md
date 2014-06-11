## NOTE
This is a work in progress

## Building

Everything was built in a [cedar stack
image](https://github.com/heroku/stack-images) using the following steps.

`chroot` preparation:

```bash
mkdir app tmp
sudo /vagrant/bin/install-stack cedar64-2.0.0.img.gz
sudo mount -o bind /dev /mnt/stacks/cedar64-2.0.0/dev/
sudo mount -o bind /home/vagrant/tmp /mnt/stacks/cedar64-2.0.0/tmp/
sudo mount -o bind /home/vagrant/app /mnt/stacks/cedar64-2.0.0/app/
sudo chroot /mnt/stacks/cedar64-2.0.0
```

```bash
cd tmp/

curl -LO http://download.osgeo.org/libtiff/tiff-4.0.3.tar.gz
curl -LO http://downloads.sourceforge.net/libpng/libpng-1.6.11.tar.xz
curl -LO http://www.nasm.us/pub/nasm/releasebuilds/2.11.05/nasm-2.11.05.tar.xz
curl -LO http://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-1.3.1.tar.gz
curl -LO ftp://sourceware.org/pub/libffi/libffi-3.1.tar.gz
curl -LO http://pkgconfig.freedesktop.org/releases/pkg-config-0.28.tar.gz
curl -LO http://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.tar.gz
curl -LO http://ftp.gnome.org/pub/gnome/sources/glib/2.40/glib-2.40.0.tar.xz
curl -LO http://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.30/gdk-pixbuf-2.30.8.tar.xz
sudo chroot /mnt/stacks/cedar64-2.0.0
```

Then just run the included build.sh

