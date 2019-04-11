#!/bin/bash

#echo "git push"
REMOTE=$(git config --get remote.origin.url)
echo $REMOTE
COMMIT=$(git log -1 --pretty=%B)
echo $COMMIT

mkdir ../unity-package-manager
git clone --branch=unity-package-manager $REMOTE ../unity-package-manager

git archive -o ../unity-package-manager/archive.tar HEAD:Assets/Trismegistus

Ci/show_tree.sh  ../unity-package-manager

cd ../unity-package-manager

ls
git branch unity-package-manager-test $(git rev-parse HEAD)
git checkout unity-package-manager-test
echo "Archive content:"
tar -tf archive.tar
tar -xf archive.tar --overwrite
rm archive.tar
ls

git add -A

echo "Diffs:"
git diff --cached

#Ci/show_tree.sh

#git config --global user.email "travis@travis-ci.org"
#git config --global user.name "Travis CI"
#git config --global push.default current


git commit -m "$COMMIT"
#git push https://$GITHUB_TOKEN@github.com/hermesiss/unity-navigation-splines.git unity-package-manager-test