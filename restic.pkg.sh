name=restic
version=0.8.0
source=("https://github.com/restic/restic/releases/download/v$version/restic-$version.tar.gz")
cksum=(7b4c65fae9cf9cb7ce70928fe6580fa9d077c425e1831958098ebc4537ae16c2)

build_phase() {
	go run build.go
}

install_phase() {
	mkdir -p "$pkgdir/bin" "$pkgdir/share/man/man1"
	cp restic "$pkgdir/bin"
	cp -t "$pkgdir/share/man/man1" doc/man/*.1
}
