name=st
version=0.7
source=("http://dl.suckless.org/st/st-$version.tar.gz" st.config.h \
	"https://st.suckless.org/patches/solarized/st-no_bold_colors-0.7.diff")
cksum=(358bca5bfc6ee85352dcd4f45f13f78474e5de42  \
	3ce8d7d7d4527f102088da4e328244dd78066b05 \
	d089f953f091933fa867416648d497a87bde3461)

build_phase() {
	patch -p1 < "$builddir/${source[2]##*/}"
	make
}

install_phase() {
	TERMINFO="$pkgdir/share/terminfo"
	mkdir -p "$TERMINFO"
	autosudo make PREFIX="$pkgdir" install
}
