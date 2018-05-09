# shorten a git revision for use in a version number
gitver() {
	echo "$1" | head -c7
}

download_phase() {
	local cachedir
	cachedir="${XDG_CACHE_HOME:-$HOME/.cache}/stew/${name}${version:+-$version}"

	if test ${#source[@]} -ne ${#cksum[@]}; then
		error 3 "$name:" 'len($source) != len($cksum)'
	fi

	mkdir -p "$cachedir"
	cd "$cachedir"
	for i in ${!source[@]}; do
		fetch "${source[$i]}"
		if ! verify_cksum $(destname "${source[$i]}") "${cksum[$i]}"; then
			error 3 "could not verify integrity of file $(destname "${source[$i]}")"
		fi
	done

	for repo in "${gitrepo[@]}"; do
		reponame="${repo%@*}"
		repobase=$(basename "$reponame" .git)
		reporev="${repo##*@}"
		git clone "$reponame" || true
		cd "$repobase"
		if test "$reporev" != "$reponame"; then
			git checkout "$reporev"
		else
			git pull
		fi
		cd ..
	done
}

fetch() {
	local src dest
	src="${1%>*}"
	dest=$(destname "$1")
	if ! test -f "$dest"; then
		echo "fetching $dest" >&2
		curl -L "$src" > "$dest"
	fi
}

destname() {
	local dest
	dest="${1##*/}"
	dest="${dest##*>}"
	if test -f "$pkgpath/$dest"; then
		echo "$pkgpath/$dest"
	else
		echo "$dest"
	fi
}

# `verify_cksum file sum` returns null (a.k.a. true) only if file matches sum
verify_cksum() {
	local hashlen sum
	hashlen=$(echo -n "$2" | wc -c)

	case "$hashlen" in
	32)
		sum=$(md5sum "$1" | cut -d ' ' -f 1) ;;
	40)
		sum=$(sha1sum "$1" | cut -d ' ' -f 1) ;;
	64)
		sum=$(sha256sum "$1" | cut -d ' ' -f 1) ;;
	128)
		sum=$(sha512sum "$1" | cut -d ' ' -f 1) ;;
	esac

	test "$sum" = "$2"
}

depends_phase() {
	local stewprereqs
	stewprereqs=(build-essential stow curl git)

	for stewdep in "${depends[@]}"; do
		stew add "$stewdep"
	done

	for debdep in "${stewprereqs[@]}" "${debdepends[@]}"; do
		if ! deb_is_installed "$debdep"; then
			sudo apt install "${stewprereqs[@]}" "${debdepends[@]}"
			break
		fi
	done
}

deb_is_installed() {
	if type dpkg >/dev/null 2>&1; then
		dpkg -s "$1" >/dev/null 2>&1
	fi
}

setup_phase() {
	# work in temporary directory
	if test -z "$TMPDIR"; then
		TMPDIR="/tmp"
	fi
	builddir="$TMPDIR/stew.$$.$name-build"
	mkdir "$builddir"
	for file in "${source[@]}"; do
		cp "$(destname "$file")" "$builddir"
	done

	for repo in "${gitrepo[@]}"; do
		cp -R $(basename "${repo%@*}" .git) "$builddir"
	done

	cd "$builddir"

	# set build flags
	eval "$(dpkg-buildflags --export=sh)"

	export LD_RUN_PATH="$prefix/lib"
	export PKG_CONFIG_PATH="$prefix/lib/pkgconfig"

	export GOBIN="$pkgdir/bin"
	export GOPATH="$builddir"
}

unpack_phase() {
	for file in "${source[@]}"; do
		case "$file" in
		*.tar|*.tar.[gx]z|*.tar.bz2|*.t[bgx]z|*.tb2|*.tbz2|*.zip|*.7z)
			extract "$(destname "$file")"
		esac
	done

	for dir in */; do
		test -d "$dir" && cd "$dir" || true
		return
	done
}

extract() {
	case "$1" in
	*.tar)
		tar x < "$1" ;;
	*.tar.bz2|*.tb2|*.tbz|*.tbz2)
		bunzip2 < "$1" | tar x ;;
	*.tar.gz|*.tgz)
		gunzip < "$1" | tar x ;;
	*.tar.xz|*.txz)
		unxz < "$1" | tar x ;;
	*.zip)
		unzip "$1" ;;
	*.7z)
		7z x "$1" ;;
	esac
}

gopathify() {
	mkdir -p "src/${1%/*}"
	mv "${1##*/}" "src/${1%/*}"
	cd "src/$1"
}

configure_phase() {
	# include suckless-style config.h file
	if test -f "../$name.config.h"; then
		cp "../$name.config.h" config.h
	fi

	if test -x configure; then
		if test ${#configureflags[@]} -eq 0; then
			configureflags=("--prefix=${prefix}")
		fi
		./configure "${configureflags[@]}"
	fi
}

build_phase() {
	if test -f makefile -o -f Makefile -o -f GNUmakefile; then
		make
	fi
}

install_phase() {
	if test -f makefile -o -f Makefile -o -f GNUmakefile; then
		autosudo make PREFIX="$pkgdir" install
	fi

	if find . -name '*.[to]t[fc]' | grep -q ''; then
		mkdir -p "$pkgdir/share/fonts"
		find . -name '*.[to]t[fc]' -print0 | xargs -0 cp -t "$pkgdir/share/fonts"
	fi
}

cleanup_phase() {
	cd
	case "$builddir" in
	"${TMPDIR:-/tmp}/stew.$$.$name-build")
		rm -rf "$builddir"
		;;
	esac
}

# calls sudo unless prefix is in /home
autosudo() {
	case "$prefix" in
	/home/*)
		"$@"
		;;
	*)
		sudo "$@"
		;;
	esac
}

stow_phase() {
	# autosudo chmod -R a-w $stowdir/$name-$version
	autosudo stow -d "$stowdir" "$name${version:+-$version}"
}
