#!/bin/sh

SRC=ftp://ftp.gnu.org/gnu/hello/hello-2.5.tar.gz
SCRIPT=$(pwd)/sessions/version-control-$(date +%Y%m%dT%H:%M).script

rm -rf work
mkdir work
cd work || exit 1

echo "+ Getting source code."
curl -s -O $SRC

echo "+ Unpacking code."
tar xzf hello-2.5.tar.gz

echo "+ Setting up repositories."
mkdir repos

svnadmin create repos/sample1
SAMPLEREPO=file://$(pwd)/repos/sample1
export SAMPLEREPO

svn mkdir -m 'create repository layout' \
	$REPO/{trunk,branches,tags}

svnadmin create repos/hello
HELLOREPO=file://$(pwd)/repos/hello/
export HELLOREPO

svn mkdir -m 'create repository layout' \
	$HELLOREPO/{trunk,branches,tags}

svn import -m 'import version 2.5' hello-2.5 $HELLOREPO/trunk

svn co $HELLOREPO/trunk work1


PS1="$ "
export PS1

VISUAL=vim
EDITOR=vim
export EDITOR VISUAL

install -d ../sessions
exec script $SCRIPT bash

