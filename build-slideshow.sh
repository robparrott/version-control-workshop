#!/bin/bash

SOURCE_FILES="why_use_vc.md git.md intro.md subversion.md version-control.md \
               history_of_vc.md seealso.md    \
              vc_models.md  vocabulary.md"

rm -f index.html
pushd docs
cat ../html/pre.html ${SOURCE_FILES} ../html/post.html > ../index.html
popd

