name=plan9port
revision=657f699ef7e5a91a529337cac76ed48c68a28583
version=20161120.$(gitver "$revision")
source=("https://github.com/9fans/plan9port/archive/$revision.tar.gz")
cksum=(e9f379f51588bf3db255f8fa1261dcdfd692eaeb8fa0b7158e1a528070f13a2a)

build_phase() {
	./INSTALL -r "$prefix/lib/plan9"
}

install_phase() {
	mkdir -p "$pkgdir/lib/plan9"
	cp -r * "$pkgdir/lib/plan9"
}
