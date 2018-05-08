name=rclone
version=1.40
depends=(go)
gitrepo=("https://github.com/ncw/rclone@v${version}")

unpack_phase() {
	gopathify github.com/ncw/rclone
}

build_phase() {
	go build
}

install_phase() {
	mkdir -p "$pkgdir/bin" "$pkgdir/share/man/man1"
	cp rclone "$pkgdir/bin"
	cp rclone.1 "$pkgdir/share/man/man1"
}
