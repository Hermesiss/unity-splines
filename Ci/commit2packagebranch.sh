#!/bin/sh

echo "git push"

git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
git config --global push.default current

ARCHIVE_NAME = archive.tar

git archive -o $ARCHIVE_NAME HEAD:Assets/Trismegistus
git checkout unity-package-manager
tar -xf $ARCHIVE_NAME
rm $ARCHIVE_NAME
git add -A
git push https://$GITHUB_TOKEN@github.com/hermesiss/unity-navigation-splines.git unity-package-manager
