name=rclone
version=1.40

unpack_phase() {
	mkdir -p src/github.com/ncw
	cd src/github.com/ncw
	git clone https://github.com/ncw/rclone
	cd ./rclone
	git checkout "v$version"
}

build_phase() {
	go build
}

install_phase() {
	mkdir -p "$pkgdir/bin" "$pkgdir/share/man/man1"
	cp rclone "$pkgdir/bin"
	cp rclone.1 "$pkgdir/share/man/man1"
}
