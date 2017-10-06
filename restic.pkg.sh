name=restic
version=0.7.3
source=("https://github.com/restic/restic/releases/download/v$version/restic-$version.tar.gz")
cksum=(6d795a5f052b3a8cb8e7571629da14f00e92035b7174eb20e32fd1440f68aaff)

build_phase() {
	go run build.go
}

install_phase() {
	mkdir -p "$pkgdir/bin"
	cp restic "$pkgdir/bin"
}
