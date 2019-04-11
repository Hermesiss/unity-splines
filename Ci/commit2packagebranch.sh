#!/bin/bash

#echo "git push"
REMOTE=$(git config --get remote.origin.url)
echo $REMOTE
COMMIT=$(git log -1 --pretty=%B)
echo $COMMIT

mkdir Hermesiss/unity-package-manager
git clone --depth=5 --branch=unity-package-manager $REMOTE Hermesiss/unity-package-manager

git archive -o Hermesiss/unity-package-manager/archive.tar HEAD:Assets/Trismegistus
#Ci/show_tree.sh

cd Hermesiss/unity-package-manager

tar -xf archive.tar
rm archive.tar

git add -A

git diff

#Ci/show_tree.sh

#git config --global user.email "travis@travis-ci.org"
#git config --global user.name "Travis CI"
#git config --global push.default current

#git push https://$GITHUB_TOKEN@github.com/hermesiss/unity-navigation-splines.git unity-package-manager