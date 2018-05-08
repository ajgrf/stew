name=hugo
version=0.40.1

unpack_phase() {
	mkdir -p src/github.com/gohugoio
	cd src/github.com/gohugoio
	git clone https://github.com/gohugoio/hugo
	cd ./hugo
	git checkout "v$version"
}

build_phase() {
	export GOPATH="$builddir"
	dep ensure
	go build
	./hugo gen man
}

install_phase() {
	mkdir -p "$pkgdir/bin" "$pkgdir/share/man/man1"
	cp hugo "$pkgdir/bin"
	cp ./man/*.1 "$pkgdir/share/man/man1"
}
