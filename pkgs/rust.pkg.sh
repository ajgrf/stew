name=rust
version=1.20.0
source=("https://static.rust-lang.org/dist/rust-$version-x86_64-unknown-linux-gnu.tar.gz")
cksum=(ca1cf3aed73ff03d065a7d3e57ecca92228d35dc36d9274a6597441319f18eb8)

install_phase() {
	./install.sh --prefix="$pkgdir"
}
