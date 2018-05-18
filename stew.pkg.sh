name=stew
version=0.1.0
aptdepends="build-essential curl git stow"
homepage="https://github.com/ajgrf/stew"
description="simple package manager using GNU Stow"

unset -f download_phase
unset -f setup_phase
unset -f unpack_phase
unset -f build_phase

install_phase() {
	mkdir -p "$pkgdir/bin" "$pkgdir/lib/stew" "$mandir/man1" "$mandir/man5"
	cp stew "$pkgdir/bin"
	cp stdenv.shlib "$pkgdir/lib/stew"
	cp stew.1 "$mandir/man1"
	cp stew.5 "$mandir/man5"
}
