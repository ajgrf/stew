name=adapta-gtk-theme
version=3.91.2.233
source=("https://github.com/adapta-project/adapta-gtk-theme/archive/$version.tar.gz")
cksum=(196ccf090b223f31aa5fd4815886e99619a22f90e7aaaf11aa35d115d5a9777b)

# sassc inkscape libxml2-utils
configure_phase() {
	./autogen.sh --prefix="$pkgdir"
}
