name=st
version=0.7
source=("http://dl.suckless.org/st/st-$version.tar.gz" st.config.h \
	"https://st.suckless.org/patches/solarized/st-no_bold_colors-0.7.diff" \
	"https://st.suckless.org/patches/scrollback/st-scrollback-0.7.diff")
cksum=(358bca5bfc6ee85352dcd4f45f13f78474e5de42  \
	3d9e20c32d3773e8d17364397266c9f3db0e6f5d \
	d089f953f091933fa867416648d497a87bde3461 \
	f42d0b0ae25491792acbc6b3ffab025027957a13)

build_phase() {
	patch -p1 < "$builddir/${source[2]##*/}"
	patch -p1 < "$builddir/${source[3]##*/}"
	make
}

install_phase() {
	TERMINFO="$pkgdir/share/terminfo"
	mkdir -p "$TERMINFO"
	autosudo make PREFIX="$pkgdir" install
}
