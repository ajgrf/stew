name=go
version=1.9.1
source=("https://storage.googleapis.com/golang/go$version.src.tar.gz")
cksum=(a84afc9dc7d64fe0fa84d4d735e2ece23831a22117b50dafc75c1484f1cb550e)

build_phase() {
	export GOBIN="$pkgdir/bin"
	export GOPATH=""
	export GOROOT_BOOTSTRAP="$prefix/lib/go1.4-bootstrap"
	export GOROOT_FINAL="$prefix/lib/$name"
	( cd ./src && ./make.bash )
}

install_phase() {
	cd ..
	mkdir -p "$pkgdir/lib"
	cp -r go "$pkgdir/lib/$name"
	mv "$pkgdir/lib/$name/bin" "$pkgdir"
}
