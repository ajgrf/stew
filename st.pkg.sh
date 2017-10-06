name=st
version=0.7
source=("http://dl.suckless.org/st/st-$version.tar.gz" st.config.h)
cksum=(358bca5bfc6ee85352dcd4f45f13f78474e5de42  \
	d50bcefb9256355fc5a20115fd8f4af1ef166b98)

install_phase() {
	TERMINFO="$pkgdir/share/terminfo"
	mkdir -p "$TERMINFO"
	autosudo make PREFIX="$pkgdir" install
}
