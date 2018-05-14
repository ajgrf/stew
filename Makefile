# Copyright 2016 Alex Griffin.  See LICENSE file for details.

STEWPREFIX ?= ${HOME}/.local

all: options

options:
	@echo stew make options:
	@echo "STEWPREFIX = ${STEWPREFIX}"

README.md: stew.1
	@mandoc -T markdown $< | markdownfmt > $@

install: options
	@echo "installing under ${STEWPREFIX}"
	@STEWPKGS=. ./stew -i stew

uninstall:
	@STEWPKGS=. ./stew -r stew

.PHONY: all options install uninstall
