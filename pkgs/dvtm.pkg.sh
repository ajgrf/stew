name=dvtm
version=20161211.b73aba5
revision=b73aba5c17b10eb9bbfaea6abe0de9802225573d
source=("https://github.com/martanne/dvtm/archive/$revision.tar.gz>$name-$version.tar.gz" \
	dvtm.config.h)
cksum=(5631715ad69350639ebabc05fa8d72a27960c4ecdba679666d8926800261d316 \
	86e185e30b9451f6cb948bb002963973bed88e9ae0a9a4b52ba9d2a53afd3711)

install_phase() {
	TERMINFO="$pkgdir/share/terminfo"
	mkdir -p "$TERMINFO"
	autosudo make PREFIX="$pkgdir" install
}
