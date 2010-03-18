#!/bin/sh

SRC=ftp://ftp.gnu.org/gnu/hello/hello-2.5.tar.gz

rm -rf work
mkdir work
cd work || exit 1

echo "+ Getting source code."
curl -s -O $SRC

echo "+ Unpacking code."
tar xzf hello-2.5.tar.gz

echo "+ Setting up repositories."
svnadmin create repo1
REPO=file://$(pwd)/repo1
export REPO

svn mkdir -m 'create repository layout' \
	$REPO/{trunk,branches,tags}

PS1="$ "
export PS1

VISUAL=vim
EDITOR=vim
export EDITOR VISUAL

install -d ../sessions
exec script ../sessions/version-control-$(date +%Y-%m-%dT%H:%M).script bash

