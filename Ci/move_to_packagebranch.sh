#!/bin/bash

#echo "git push"
REMOTE=$(git config --get remote.origin.url)
echo $REMOTE
COMMIT=$(git log -1 --pretty=%B)
echo $COMMIT

echo "TARGET_BRANCH is $TARGET_BRANCH"
mkdir ../$TARGET_BRANCH
git clone --branch=$TARGET_BRANCH $REMOTE ../$TARGET_BRANCH

git archive -o ../$TARGET_BRANCH/archive.tar HEAD:$FOLDER_TO_EXPORT

Ci/show_tree.sh  ../$TARGET_BRANCH

cd ../$TARGET_BRANCH

ls

echo "TEST_RUN is $TEST_RUN"
if $TEST_RUN ; then
    echo "Test build"
    TEST_BRANCH=upm_test
    if [ $(git branch $TEST_BRANCH --list)!=$TEST_BRANCH ] ; then 
        echo "branch $TEST_BRANCH not exists, creating new at $(git rev-parse HEAD)"
        git branch $TEST_BRANCH $(git rev-parse HEAD)
    else
        echo "branch $TEST_BRANCH exists"
    fi
    git checkout -B $TARGET_BRANCH
    PUSH_BRANCH=$TEST_BRANCH
else    
    PUSH_BRANCH=$TARGET_BRANCH
fi


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
git push https://$GITHUB_TOKEN@github.com/hermesiss/unity-navigation-splines.git unity-package-manager-test