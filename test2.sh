#!/bin/sh

git filter-branch -f --env-filter '
if [ "$GIT_AUTHOR_NAME" = "KingPin" ]
then 
	echo "trouvé"
	GIT_COMMITTER_NAME="test" &&
       GIT_AUTHOR_NAME="test" &&
       GIT_COMMITTER_EMAIL="test@test.te"&&
       GIT_AUTHOR_EMAIL="test@test.te"&&
	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
     	export GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL
fi' -- --all
