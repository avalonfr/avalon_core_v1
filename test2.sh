#!/bin/sh

git filter-branch --env-filter '

an="$GIT_AUTHOR_NAME"
am="$GIT_AUTHOR_EMAIL"
cn="$GIT_COMMITTER_NAME"
cm="$GIT_COMMITTER_EMAIL"

if [ "$GIT_COMMIT" = "16565316e4a177d152a64a13db14e7c0c8335c2b" ]
then 
	echo "trouve"
	echo "$GIT_AUTHOR_NAME"
	echo "$GIT_COMMITTER_NAME"
fi
if [ "$GIT_COMMIT" = "0d4bbd96410dfa6d9d9bf761f26ba7651da38a96" ]
then 
	echo "trouve bis"
	echo "$GIT_AUTHOR_NAME"
	echo "$GIT_COMMITTER_NAME"
fi
if [ "$GIT_AUTHOR_NAME" = "malcromdev@gmail.com" ]
then
    cn="malcromdev"
    cm="malcromdev@gmail.com"
    an="malcromdev"
    am="malcromdev@gmail.com"
fi
if [ "$GIT_COMMITTER_NAME" = "malcromdev@gmail.com" ]
then
    cn="malcromdev"
    cm="malcromdev@gmail.com"
    an="malcromdev"
    am="malcromdev@gmail.com"
fi
export GIT_AUTHOR_NAME="$an"
export GIT_AUTHOR_EMAIL="$am"
export GIT_COMMITTER_NAME="$cn"
export GIT_COMMITTER_EMAIL="$cm"
'