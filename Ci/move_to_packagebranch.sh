#!/bin/bash

#echo "git push"
REMOTE=$(git config --get remote.origin.url)
echo $REMOTE
COMMIT=$(git log -1 --pretty=%B)
echo $COMMIT

echo "TARGET_BRANCH is $TARGET_BRANCH"
mkdir ../$TARGET_BRANCH

if [ "$(git ls-remote origin $TARGET_BRANCH | wc -l)" != 1]; then
    git clone --depth=1 $REMOTE
    git checkout -b $TARGET_BRANCH
else
    git clone --branch=$TARGET_BRANCH $REMOTE ../$TARGET_BRANCH
fi

rm ../$TARGET_BRANCH/* -dr

git archive -o ../$TARGET_BRANCH/archive.tar HEAD:$FOLDER_TO_EXPORT

Ci/show_tree.sh  ../$TARGET_BRANCH

cd ../$TARGET_BRANCH

ls

echo "Archive content:"
tar -tf archive.tar
tar -xf archive.tar --overwrite
rm archive.tar

git add -A

echo "Diffs:"
git diff --cached

git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"

git commit -m "$COMMIT"

git push https://$GITHUB_TOKEN@${REMOTE#*//} $PUSH_BRANCH