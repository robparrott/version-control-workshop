#!/bin/sh

PKG=hello-2.5
URL=ftp://ftp.gnu.org/gnu/hello/${PKG}.tar.gz
TOP=$(pwd)

pause () {
	[ "$NOPAUSE" = 1 ] && return

	echo "[PAUSE]" >&2
	read junk
}

ex () {
	echo
	echo "  $ $*"
	pause
	"$@" 2>&1 | sed 's/^/  /'
	echo
	pause
}

while getopts 'nf' ch; do
	case $ch in
		(n) NOPAUSE=1;;
		(f) FORCE=1;;

		(\?)	exit 2;;
	esac
done
shift $(( $OPTIND - 1 ))

if ! curl --version > /dev/null 2>&1; then
	echo "ERROR: You need 'curl' installed in order to run this script." >&2
	exit 1
fi

if ! svn --version > /dev/null 2>&1; then
	echo "ERROR: You need 'Subversion' installed in order to run this script." >&2
	exit 1
fi

if [ -d "subversion-example" ]; then
	if [ "$FORCE" = 1 ]; then
		rm -rf subversion-example
	else
		echo "ERROR: A directory named 'subversion-example' already exists." >&2
		exit 1
	fi
fi

#trap "rm -rf $(pwd)/subversion-example" 0
mkdir subversion-example
cd subversion-example

cat <<EOF
==================
Subversion example
==================

Welcome to our Subversion example!  For the purposes of this example,
we'll be using GNU's "hello" project, available from
$URL::
EOF

ex curl -s -o $PKG.tar.gz $URL
ex tar xzf $PKG.tar.gz
ex ls -l $PKG

cat <<EOF
Creating a repository
=====================

We use the *svnadmin create* command to create a local repository::
EOF

ex svnadmin create repo

cat <<EOF
A repository is essentially a database that contains the history of project
files and other metadata.  The top level looks like this::
EOF

ex ls repo

cat <<EOF
You will not generally interact directly with the repository unless you are 
editing files in the *conf/* directory.
EOF

REPO=file://$(pwd)/repo

cat <<EOF
We'll want to create the recommended repository layout before we start
importing any code::
EOF

ex svn mkdir -m 'create repo layout' $REPO/{trunk,branches,tags}

cat <<EOF
Importing files
===============

We'll use the *svn import* command to add this project to our repository::
EOF

ex svn import -m 'import hello project' $PKG $REPO/trunk/
ex svn ls $REPO

cat <<EOF
Checkout out a repository
=========================

We use the *svn checkout* command to get a working copy of the repository.  
In this example we'll create a working copy of the trunk named "work1"::
EOF

ex svn co $REPO/trunk work1

cat <<EOF
And while we're at it, we'll check out a second working copy that we'll
need for examples later on::
EOF

ex svn co $REPO/trunk work2

cat <<EOF
What's changed?
===============

Now let's make some changes to the code.  We're going to add
the new *--slack* option.  This will be totally awesome::
EOF

(
cd work1
ex patch -p0 < $TOP/slack.patch

cat <<EOF
Let's ask Subversion what files we've modified::
EOF

ex svn status

cat <<EOF
We can also ask for a patch-style listing of differences::
EOF

ex svn diff

cat <<EOF
Committing changes
==================

We use the *svn commit* command to send our changes back to the repository::
EOF

ex svn commit -m 'this implements my totally awesome --slack option'
)

cat <<EOF
Managing conflicts
==================

What if two collaborators make conflicting changes to the code?  For 
example, my colleague Matthew has decided to implement the new *--loud*
command line option.  We'll explore this scenario in the second 
working copy of the repository we made earlier.

EOF

(
cd work2

cat <<EOF
First, Matthew makes his changes::
EOF

ex patch -p0 < $TOP/loud.patch

cat <<EOF
Matthew would also like to add a package specification file so that he
can build a Fedora package from this project::
EOF

ex cp $TOP/hello.spec .
ex svn add hello.spec

cat <<EOF
Matthew now has some pending changes in his working copy::
EOF

ex svn status

cat <<EOF
He tries to commit them to the repository::
EOF

ex svn commit -m 'now i can say hello loudly with --loud'

cat <<EOF
The commit fails because the repository is now newer than Matthew's working
copy. Matthew needs to update his working copy::
EOF

ex svn update --accept postpone

cat <<EOF
As you might expect, Subversion indicates that there are conflicts
between my changes and Matthew's changes.  Running *svn status* shows
the conflicting status of the code, and also shows that some other
files have been created::
EOF

ex svn status

cat <<EOF
If we look at the *src/hello.c*, we see that the conflicting sections
of code have been marked, like this::

  <<<<<<< .mine
    { "loud", no_argument, NULL, 'l' },
  =======
    { "slack", no_argument, NULL, 's' },
  >>>>>>> .r3

This indicates that the top section (".mine") contains the local
changes, and the bottom section (".r3", after the "=======") contains
changes that were in the remote repository.

Matthew decides that the *--slack* option is much more important::
EOF

ex svn resolve --accept theirs-conflict src/hello.c

cat <<EOF
Now that the conflict has been resolved, Matthew can commit his
remaining changes to the repository::
EOF

ex svn commit -m 'added an rpm spec file'
)

