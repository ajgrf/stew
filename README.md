STEW(1) - General Commands Manual

NAME
====

**stew** - manage software with GNU Stow

SYNOPSIS
========

**stew** \[**-ilrs**\] \[*pkg&nbsp;...*\]

DESCRIPTION
===========

**stew** is a simple source-based package manager for installing software outside of your distribution's repositories. It leverages the excellent stow(8) utility to manage software, but alleviates much of the boilerplate you might otherwise need to write if you wanted to automate your stow installations.

The operations are as follows:

**-i**

> Install the specified packages. This is the default operation when a package name is specified.

**-l**

> List installed packages. This is the default operation when no packages are specified.

**-r**

> Remove the specified packages. If **stew** can't find the corresponding package definition in `STEWPKGS`, you may need to specify the version number as well.

**-s**

> Search available packages. The rest of the command line is used as a list of search terms over package names and descriptions. Packages must match all of the search terms. If no arguments are given, display all available packages.

For documentation on creating your own packages, see stew(5).

INSTALLATION
============

To install **stew** into `STEWPREFIX`, run the following command from the source directory:

```
$ make install
```

Then make sure *$STEWPREFIX/bin* is in your `PATH`.

ENVIRONMENT
===========

`STEWPKGS`

> Search for package definitions in this directory, (defaults to the current directory).

`STEWPREFIX`

> Install software under this directory (defaults to *~/.local*).

EXIT STATUS
===========

The **stew** utility exits&#160;0 on success, and&#160;&gt;0 if an error occurs.

EXAMPLES
========

Install the `hello` package:

```
$ stew hello
```

Remove the `hello` package:

```
$ stew -r hello
```

Upgrade the `hello` package to a new version (an uninstall operation followed by an install):

```
$ stew -r hello-2.9 -i hello
```

List installed packages:

```
$ stew
```

List available packages:

```
$ stew -s
```

Search available packages matching both patterns 'go' and 'font':

```
$ stew -s go font
```

SEE ALSO
========

stew(5), stow(8)

AUTHORS
=======

Written by Alex Griffin &lt;[a@ajgrf.com](mailto:a@ajgrf.com)&gt;, and licensed under the ISC license. See the LICENSE file for details.

BUGS
====

Although stew's design should work fine under a variety of environments, it may not yet be usable outside of Debian-based systems.

No effort has been made to secure **stew**. You should not use it with untrusted input!

Linux 4.16.0-0.bpo.1-amd64 - May 11, 2018
