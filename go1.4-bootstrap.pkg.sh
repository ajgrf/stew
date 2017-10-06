name=go1.4-bootstrap
version=20170531
source=("https://storage.googleapis.com/golang/go1.4-bootstrap-$version.tar.gz")
cksum=(49f806f66762077861b7de7081f586995940772d29d4c45068c134441a743fa2)

build_phase() {
	export GOBIN=""
	export GOPATH=""
	export GOROOT_FINAL="$prefix/lib/$name"
	( cd ./src && ./make.bash )
}

install_phase() {
	cd ..
	mkdir -p "$pkgdir/lib"
	cp -r go "$pkgdir/lib/$name"
}
