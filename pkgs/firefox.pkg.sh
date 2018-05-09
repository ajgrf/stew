name=firefox
version=57.0
source=("https://download-installer.cdn.mozilla.net/pub/firefox/releases/57.0/linux-x86_64/en-US/firefox-$version.tar.bz2" firefox.desktop)
sum=(c2cae016089e816c03283a359c582efab3bca34e6048ecc2382b43c1eb342457
	5bc512b747706793365da8ed51c9550804a7ee65e9073db84ac641149756c524)

install_phase() {
	mkdir -p "$pkgdir/lib/firefox" "$pkgdir/share/applications" "$pkgdir/bin"
	cp -r -t "$pkgdir/lib/firefox" *
	cp ../firefox.desktop "$pkgdir/share/applications/"
	ln -s ../lib/firefox/firefox "$pkgdir/bin/firefox"
}
