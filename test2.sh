#!/bin/sh

git filter-branch -f --env-filter '
if [ "$GIT_AUTHOR_NAME" = "KingPin" ]
then 
	an="test"
	am="test@test.te"
	cn="test"
	cm="test@test.te"
	echo "trouvé"
	GIT_COMMITTER_NAME=$cn &&
    GIT_AUTHOR_NAME=$an &&
    GIT_COMMITTER_EMAIL=$cm &&
    GIT_AUTHOR_EMAIL=$am &&
	export GIT_AUTHOR_NAME &&
	export GIT_AUTHOR_EMAIL &&
    export GIT_COMMITTER_NAME &&
	export GIT_COMMITTER_EMAIL
fi' -- --all
