name=entr
version=3.6
source=("http://entrproject.org/code/entr-$version.tar.gz")
cksum=(a42746d81c548d7e557d500f93422b8ec9731d719309eb2601b8be69ae0dc8eb)

configure_phase() {
	./configure
}
