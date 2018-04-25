name=newsboat
version=2.11.1
source=("https://newsboat.org/releases/$version/newsboat-$version.tar.xz")
cksum=(aab67dcd386a3512812e1af0fddb8e1f4dce08d2a106946fe5ad405210ed37cf)

install_phase() {
	autosudo make prefix="$pkgdir" install
}
