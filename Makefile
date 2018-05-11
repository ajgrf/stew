STEWPREFIX ?= ${HOME}/.local

all: options

options:
	@echo "STEWPREFIX = ${STEWPREFIX}"

README.md: stew.1
	@mandoc -T markdown $< > $@

install: options
	@echo "installing under ${STEWPREFIX}"
	@STEWPKGS=. ./stew -i stew

uninstall:
	@STEWPKGS=. ./stew -r stew

.PHONY: all options install uninstall
