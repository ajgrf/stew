download_phase() :
setup_phase() :
unpack_phase() :

install_phase() {
	mkdir -p "$pkgdir/bin" "$pkgdir/lib/stew"
	cp stew "$pkgdir/bin"
	cp stdenv.sh gog.sh "$pkgdir/lib/stew"
}
