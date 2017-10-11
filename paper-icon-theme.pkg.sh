name=paper-icon-theme
version=1.4.0
source=("https://github.com/snwh/paper-icon-theme/archive/v1.4.0.tar.gz")
cksum=(b90f3a84634572bcba76cdd0c2a0d305a5c521c2054d3d390edffda5f233928b)

build_phase() {
	./autogen.sh
	make
}

install_phase() {
	make DESTDIR="$pkgdir" install
	mv "$pkgdir/usr/share" "$pkgdir/share"
	rmdir "$pkgdir/usr"
}
