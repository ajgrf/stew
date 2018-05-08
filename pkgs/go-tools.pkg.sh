name=go-tools
revision=c6efba04dd0d931bb11cd7f556285fa3c9305398
netrev=3bafa3320efdf0c95d056586aa9abdd05ad72ee1
version=20161019.$(gitver "$revision")
depends=(go)
source=("https://github.com/golang/tools/archive/$revision.tar.gz" \
	"https://github.com/golang/net/archive/$netrev.tar.gz")
cksum=(c0bef7339432efdab5e0f799dfd094f9fd4c30c90a8aeb74b5ebf337f8274169 \
	53ff233d596ad32b7f9890af30d49c1c5f9cddb7c603672a24973a3606ae8b44)

unpack_phase() {
	mkdir -p src/golang.org/x
	gunzip < "$revision.tar.gz" | tar x
	gunzip < "$netrev.tar.gz" | tar x
	mv "tools-$revision" src/golang.org/x/tools
	mv "net-$netrev" src/golang.org/x/net
}

install_phase() {
	go install golang.org/x/tools/cmd/...
}
