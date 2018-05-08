name=ripgrep
version=0.6.0

install_phase() {
	cargo install --root "$pkgdir" --vers "$version" ripgrep
}
