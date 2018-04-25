name=st
version=0.8.1
source=("http://dl.suckless.org/st/st-$version.tar.gz" \
	st.config.h \
	"https://st.suckless.org/patches/solarized/st-no_bold_colors-0.8.1.diff" \
	"https://st.suckless.org/patches/scrollback/st-scrollback-0.8.diff")
cksum=(c4fb0fe2b8d2d3bd5e72763e80a8ae05b7d44dbac8f8e3bb18ef0161c7266926 \
	ef2129682b192ed3fa46d7e5a2d4791b6d197dcc2d3d7b6000f6c0f2f36ed63d \
	5a6e2b745c7746228e0ee4e84214e3ac7054e6d451bc5843364e878bb2011e3b \
	8279d347c70bc9b36f450ba15e1fd9ff62eedf49ce9258c35d7f1cfe38cca226)

build_phase() {
	patch -p1 < "$builddir/${source[2]##*/}"
	patch -p1 < "$builddir/${source[3]##*/}"
	make
}

install_phase() {
	export TERMINFO="$pkgdir/share/terminfo"
	mkdir -p "$TERMINFO"
	autosudo make PREFIX="$pkgdir" install
}
