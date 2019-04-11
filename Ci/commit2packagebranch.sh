#!/bin/sh

echo "git push"

show_tree.sh

git archive -o archive.tar HEAD:Assets/Trismegistus

show_tree.sh

git checkout unity-package-manager

show_tree.sh

tar -xf archive.tar
rm archive.tar
git add -A

show_tree.sh

#git config --global user.email "travis@travis-ci.org"
#git config --global user.name "Travis CI"
#git config --global push.default current

git push https://$GITHUB_TOKEN@github.com/hermesiss/unity-navigation-splines.git unity-package-manager