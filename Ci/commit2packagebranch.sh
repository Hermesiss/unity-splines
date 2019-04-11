#!/bin/bash

#echo "git push"

git archive -o archive.tar HEAD:Assets/Trismegistus

Ci/show_tree.sh

git fetch
git branch
git checkout unity-package-manager

Ci/show_tree.sh

tar -xf archive.tar
rm archive.tar
git add -A

git diff

Ci/show_tree.sh

#git config --global user.email "travis@travis-ci.org"
#git config --global user.name "Travis CI"
#git config --global push.default current

#git push https://$GITHUB_TOKEN@github.com/hermesiss/unity-navigation-splines.git unity-package-manager