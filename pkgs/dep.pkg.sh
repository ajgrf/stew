name=dep
version=0.4.1

unpack_phase() {
	mkdir -p src/github.com/golang
	cd src/github.com/golang
	git clone https://github.com/golang/dep
	cd ./dep
	git checkout "v$version"
}

install_phase() {
	mkdir -p "$pkgdir/bin"
	go install ./cmd/dep
}
