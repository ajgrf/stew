name=stack
version=1.7.1
source=("https://github.com/commercialhaskell/stack/releases/download/v$version/stack-$version-linux-x86_64.tar.gz")
cksum=(647306bbf65dd0b555486e2a32776ba1cfe0c8f380e31c6aa93abd452cb209ee)

install_phase() {
	mkdir -p "$pkgdir/bin"
	cp stack "$pkgdir/bin"
}
