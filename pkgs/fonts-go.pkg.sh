name=fonts-go
revision=f03a046406d4d7fbfd4ed29f554da8f6114049fc
version=20170330.$(gitver "$revision")

unpack_phase() {
	git clone https://go.googlesource.com/image
	cd ./image
	git checkout "$revision"
}

configure_phase() {
	cd ./font/gofont/ttfs
}
