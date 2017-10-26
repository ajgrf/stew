name=go
version=1.9.2
source=("https://storage.googleapis.com/golang/go$version.src.tar.gz")
cksum=(665f184bf8ac89986cfd5a4460736976f60b57df6b320ad71ad4cef53bb143dc)

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
