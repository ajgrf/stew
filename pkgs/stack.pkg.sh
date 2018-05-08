name=stack
version=1.5.1
source=("https://github.com/commercialhaskell/stack/releases/download/v$version/stack-$version-linux-x86_64-static.tar.gz")
cksum=(6a250cbab60870f6b933c780c96c5cafb02d066a6f2d7182bb00ec005262842b)

install_phase() {
	mkdir -p "$pkgdir/bin"
	cp stack "$pkgdir/bin"
}
