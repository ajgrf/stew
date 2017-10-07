name=mandoc
version=1.14.3
source=("http://mdocml.bsd.lv/snapshots/mandoc-$version.tar.gz")
cksum=(0b0c8f67958c1569ead4b690680c337984b879dfd2ad4648d96924332fd99528)

configure_phase() {
	cat > configure.local <<- EOF
		PREFIX="$pkgdir"
		MANDIR="$pkgdir/share/man"
		MANPATH_DEFAULT="$prefix/share/man:/usr/local/man:/usr/local/share/man:/usr/share/man"
	EOF
	./configure
}
