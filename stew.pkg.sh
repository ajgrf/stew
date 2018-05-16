name=stew
version=$(git show --no-patch --date=format:%Y%m%d --format=%cd.%h HEAD)
aptdepends=(build-essential curl git stow)
homepage="https://github.com/ajgrf/stew"
description="simple package manager using GNU Stow"

unset -f download_phase
unset -f setup_phase
unset -f unpack_phase

install_phase() {
	mkdir -p "$pkgdir/bin" "$pkgdir/lib/stew" "$mandir/man1"
	cp stew "$pkgdir/bin"
	cp stdenv.shlib "$pkgdir/lib/stew"
	cp stew.1 "$mandir/man1"
}
