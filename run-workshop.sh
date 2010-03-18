#!/bin/bash

SRC=ftp://ftp.gnu.org/gnu/hello/hello-2.5.tar.gz
SESSION=$(pwd)/sessions/version-control-$(date +%Y%m%dT%H:%M).script

pause () {
	if [ "$NOPAUSE" = 1 ]; then
		echo "$1"
		return
	fi

	while :; do
		[ "$1" ] && echo -n "$1" || echo -n "[pause]"
		read ch
		case $ch in
			(!)	PS1="workshop$ " /bin/bash;;
			(*)	break;;
		esac
	done
}

run () {
	local nopause
	
	OPTIND=0

	while getopts 'n' ch; do
		case $ch in
			(n) nopause=1;;
		esac
	done

	shift $(( $OPTIND - 1 ))
	pause "  $ $*"
	"$@" 2>&1 | sed 's/^/  /'
	[ "$nopause" = 1 ] || pause
}

slide () {
	if [ "$PAUSEAFTER" = "$1" ]; then
		NOPAUSE=0
	fi

	echo
	echo "$1"
	echo "$1" | sed 's/./=/'g
	echo
}

cd $(dirname $0)
SCRIPT_DIR=$(pwd)
SCRIPT_NAME=$(basename $0)
SCRIPT_PATH="$SCRIPT_DIR/$SCRIPT_NAME"

if [ "$1" != "nosetup" ]; then
	rm -rf work
	mkdir work
	cd work || exit 1

	echo "+ Getting source code."
	curl -s -O $SRC

	echo "+ Unpacking code."
	tar xzf hello-2.5.tar.gz

	echo "+ Setting up repositories."
	mkdir repos

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
	exec script -c "$SCRIPT_PATH nosetup" $SESSION
fi

cd work || exit 1

slide "svn: Getting help"
run svn checkout --help

slide "svn: Checking out a remote repository"
run -n svn co $HELLOREPO/trunk hello
run ls hello

(
cd hello
slide "svn: Adding files"
cat > newfile1 <<EOF
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ac ante tellus,
eget facilisis tellus. Integer ornare libero quis justo iaculis bibendum.
Mauris odio lorem, fringilla vitae venenatis id, fermentum faucibus est.
Maecenas sodales egestas dolor, sodales accumsan eros tincidunt ac.
Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac
turpis egestas.
EOF
run svn add newfile1

slide "svn: Renaming files"
run svn rename NEWS OLDNEWS

slide "svn: Removing files"
run svn rm AUTHORS

slide "svn: What's changed"
echo This is a test. >> README
run svn status
run svn diff

slide "svn: Committing changes"
run svn ci -m "made some very important changes"
)

(
cd work1
slide "svn: Updating your working copy"
run pwd
run svn update

slide "svn: Conflicts"
run sed -i s/GNU/Microsoft/g README
run svn diff
run svn ci -m 'changed GNU to Microsoft'
)

(
cd hello
run pwd
run sed -i s/GNU/Apple/g README
run svn diff
run svn ci -m 'changed GNU to Apple'
run svn update ${NOPAUSE:+--accept mine-conflict}
run svn diff
run svn ci -m 'changed GNU to Apple'
)

slide "svn: Viewing history"
(
cd hello
run svn log
)

slide "Tagging and branching"
run svn co $HELLOREPO work2

(
cd work2
run ls
run svn cp -r 1 trunk tags/hello-2.5
run svn ci -m 'tagged original as hello-2.5'
run svn cp trunk branches/hello-2.5-seas
run svn ci -m 'created branch for SEAS development'
run ls tags
run ls branches
)

slide "svn: Creating a repository"
run svnadmin create repos/sample1
REPO=file://$(pwd)/repos/sample1
run svn mkdir -m 'create repository layout' $REPO/{trunk,branches,tags}

slide "svn: Importing files"
run svn import -m 'initial import' hello-2.5 $REPO/trunk

######################################################################

rm -rf work[0-9] hello

slide "git: Getting help"
run git init --help

slide "git: Creating a repository"

(
cd hello-2.5
run pwd
run git init

slide "git: Adding files"
run git add .
run git commit -m 'initial import'

slide "git: Renaming files"
run git mv NEWS OLDNEWS

slide "git: Removing files"
run git rm AUTHORS

slide "git: What's changed: status"
echo This is a test. >> README

cat > newfile1 <<EOF
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ac ante tellus,
eget facilisis tellus. Integer ornare libero quis justo iaculis bibendum.
Mauris odio lorem, fringilla vitae venenatis id, fermentum faucibus est.
Maecenas sodales egestas dolor, sodales accumsan eros tincidunt ac.
Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac
turpis egestas.
EOF

run git status
run git add newfile1
run git status

run mv INSTALL OLDINSTALL
run git rm INSTALL
run git add OLDINSTALL
run git status

slide "git: What's changed: diffs"
run git diff
run git ci -m 'made some changes'
)

slide "git: Cloning a remote repository"
git clone --bare hello-2.5 hello.git
run git clone hello.git work1
run git clone hello.git work2

slide "git: Updating your working copy"
(
cd work1
echo This is a test. >> README
git ci -m 'made a change' README
git push
)  > /dev/null 2>&1

(
cd work2
run pwd
run git pull

slide "git: Pushing changes"
run sed -i s/GNU/Microsoft/g README
run git diff
run git ci -m 'changed GNU to Microsoft' README
run git push
)

(
slide "git: Conflicts"
cd work1
run pwd
run sed -i s/GNU/Apple/g README
run git diff
run git ci -m 'changed GNU to Apple' README
run git push
run git pull
run git checkout --ours README
run git add README
run git ci -m 'fixed conflict'
run git push
)

slide "git: Viewing history"
(
cd work1
run git log
)

slide "git: Tags"
(
cd work1
run git tag "seas-workshop"
run git tag
)

slide "git: Branches"
(
cd work1
run git checkout -b "seas-workshop-dev"
run sed -i 's/traditional/awesome/' src/hello.c
run git ci -m 'made an awesome change' src/hello.c
run git checkout master
run git merge seas-workshop-dev
run git diff seas-workshop
)

slide "git: the index"
(
cd work1
run sed -i s/Apple/Orange/g README
run git diff
run git add README
run sed -i s/Orange/IBM/g README
run git diff
run git diff HEAD
run git diff --cached
)

slide "git: Integrating w/ Subversion"
run git svn clone -s $HELLOREPO work3

(
cd work3
run git branch -a
run sed -i s/Apple/IBM/g README
run git svn dcommit
run git ci -m 'changed apple to ibm' README
run git svn dcommit
)

